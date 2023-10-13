
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/models/customer/customer_model.dart';
import 'package:lphms_storage_plugin/models/hotel/hotel_model.dart';

import '../../utility/record_prefix.dart';
import '../LHMS.dart';
import 'check_in_model.dart';

class SelfCheckInModel{
  String? pk; //SC_<CustomerId>
  String? sk; //<hotelId>
  String? gsi1; //0: waiting for check in, null: checked in or cancelled
  String? docID; //document id
  String? docType; //document type
  String? sna; //surname
  String? gna; //given name
  String? isr; //id serial number
  TemporalDate? dob; //date of birth
  String? sex; //gender
  TemporalDate? doe; //date of expire
  String? nt; //nation
  TemporalDate? cid; //apply date of the check in
  List<String?>? hnl ; //hotel name list

  //create a selfCheckIn record
  SelfCheckInModel.create({
    required HotelInfo hotelInfo,
    required CustomerInfo customerInfo,
    required String? gsi, //gsi1 =null means checked in or cancelled
  }){
    print("SelfCheckInModel.fromCustomerInfo:${customerInfo.pk}");
    pk = "${rPref[RecType.selfCheckInRec]}_${customerInfo.pk}";
    sk = hotelInfo.pk;
    docID = customerInfo.docID;
    docType = customerInfo.docType;
    sna = customerInfo.sna;
    gna = customerInfo.gna;
    isr = customerInfo.isr;
    dob = customerInfo.dob;
    sex = customerInfo.sex;
    doe = customerInfo.doe;
    nt = customerInfo.nt;
    gsi1 = gsi;
    hnl = hotelInfo.hnl;
}
  SelfCheckInModel.fromLHMS(LHMS info){
    pk = info.PK;
    docID = getDocIdFromPK();
    docType = getDocTypeFromPK();
    sna = info.sna;
    gna = info.gna;
    isr = info.isr;
    dob = info.dob;
    sex = info.sex;
    doe = info.doe;
    nt = getNcFromPK();
    gsi1 = info.GSI1;
    hnl = info.hnl;
  }

  LHMS toLHMS(){
    assert(pk!=null);
    assert(sk!=null);
    LHMS lhms = LHMS(
      PK: pk!,
      SK: sk!,
      GSI1: gsi1,
      sna: sna,
      gna: gna,
      isr: isr,
      dob: dob,
      doe: doe,
      sex: sex,
      nna: nt,
      hnl: hnl,
    );
    return lhms;
  }
  final _cuInfoPattern = r"SC_(\w+)_(\w+)_([\w\d]+)";
  String? getNcFromPK() =>
      RegExp(_cuInfoPattern).firstMatch(pk!)?.group(2);
  String? getDocIdFromPK() =>
      RegExp(_cuInfoPattern).firstMatch(pk!)?.group(3);
  String? getDocTypeFromPK() =>
      RegExp(_cuInfoPattern).firstMatch(pk!)?.group(1);
  String get customerId => pk!.split("SC_")[1];
  String getHotelName({String lang = 'lo'}){
    final reg = RegExp('_${lang}_');
    if(hnl == null) return '';
    if(hnl!.isEmpty) return '';

    final list = hnl!.where((item) => reg.hasMatch(item!)).toList();
    if(list.isEmpty){
      return list[0]!;
    }else{
      return list.first!;
    }
  }
}
//when customer check in, a check in record will be generated
extension CheckIn on SelfCheckInModel{
  toCheckInModel({
    required TemporalDateTime cid,
    TemporalDateTime? cod,
    required String rno,
  }){
    return CheckInRecord.genFromSCM(
      scm: this,
      checkInDate: cid,
      checkOutDate: cod,
      roomNumber: rno
    );
  }

  HttpPayload toHttpPayload(){
    return HttpPayload.json(
        {
          "PK": pk,
          "SK": sk,
          "GSI1": gsi1,
          "sna": sna,
          "gna": gna,
          "isr": isr,
          "dob": dob?.format(),
          "sex": sex,
          "doe": doe?.format(),
          "nna": nt,
          "hnl": hnl,
        }
    );
  }
}