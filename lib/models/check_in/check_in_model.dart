import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/models/check_in/self_check_in_model.dart';


import '../../../models/LHMS.dart';
import '../../../utility/record_prefix.dart';
//for a hotel, the actions are:
//1. check in a customer
//2. check out a customer
//3. list all customers in the hotel (parse index)
//   hotelId,
//4. list all customers in the hotel with check out status by check in date
//   hotelId, check in date,
//5. list all customers in the hotel with check out status by check out date
//   hotelId, check out date
//6. get a customer's check in status
//   hotelId, customerId

// pk: cr_<hotel id>_<customer id>, sk: <check in date>, cod(gsi): <check out date>
// GSI(cod): pk: <check out date>, sk: cr_<hotel id>_<customer id>
// GSI(ihs): pk: cr#<hotel id>#<customer id>, sk: ihs, attribute:


//6. list all customers apply for check in in the hotel( parse index)
//7. get a customer's application for check in
class CheckInRecord{
  String? pk; //CR$<hotel Id>$<customer id>
  String? sk; //<check in date>
  TemporalDateTime? cod; //gsi(cod)check out date,attribute map: rno,
  TemporalDateTime? cid; //check in date;
  String? rno; //room number
  int? ihs;//gsi(ihsIdx) in hotel status.(null means checked out,0 means checked in, 1 means cancelled)
  String? sna;
  String? gna;
  String? isr;
  TemporalDate? dob;
  TemporalDate? doe;
  String? sex;
  //?? how to do with in hotel status
  CheckInRecord.create({
    required String hotelId,
    required String customerId,
    required String roomNumber,
    required TemporalDateTime checkInDate,
    required TemporalDateTime checkOutDate,
    required int inHotelStatus,
    String? surname,
    String? givenName,
    String? issuer,
    TemporalDate? dateOfBirth,
    TemporalDate? dateExpire,
    String? gender,
  }){
    pk = "${rPref[RecType.checkInRecord]}#$hotelId#$customerId";
    sk = cid!.format();
    cid = checkInDate;
    cod = checkOutDate;
    rno = roomNumber;
    ihs = inHotelStatus;
    sna = surname;
    gna = givenName;
    isr = issuer;
    dob = dateOfBirth;
    sex = gender;
    doe = dateExpire;
}

  genPK(String hid,String cusId){
    pk = "${rPref[RecType.checkInRecord]}\$$hid$sp\$cusId";
  }
  //create from self check in model
  CheckInRecord.genFromSCM({
    required SelfCheckInModel scm,
    required TemporalDateTime checkInDate,
    required String roomNumber,
    TemporalDateTime? checkOutDate,
  }){
    pk = genPK(scm.sk!, scm.customerId);
    sk = checkInDate.format();
    cod = checkOutDate;
    rno = roomNumber;
    cid = checkInDate;
    sex = scm.sex;
    sna = scm.sna;
    gna = scm.gna;
    isr = scm.isr;
    dob = scm.dob;
    doe = scm.doe;
    ihs = 1;
  }

  CheckInRecord.genCheckOut({
    required CheckInRecord checkInRecord,
    required TemporalDateTime checkOutDate,
}){
    checkInRecord.ihs = null;
    checkInRecord.cod = checkOutDate;
}

  CheckInRecord.fromLHMS(LHMS lhms){
    pk = lhms.PK;
    sk = lhms.SK;
    cod = lhms.cod;
    cid = lhms.cid;
    rno = lhms.rno;
    sex = lhms.sex;
    sna = lhms.sna;
    gna = lhms.gna;
    isr = lhms.isr;
    dob = lhms.dob;
    doe = lhms.doe;
    ihs = lhms.ihs;
  }
  LHMS toLHMS(){
    return LHMS(PK: pk!, SK: sk!, cod: cod, cid: cid,rno: rno, ihs: ihs,sex: sex,sna: sna,gna: gna,isr: isr,dob: dob,doe: doe);
  }

  //cr$HO_RG_<prov>_<district>_<4 digits of id serial number>$CU_<Document Type>_<Nation Code>_<Document ID>
  //2/1/2/1/3/1/2/1/4/1/2/1/1/2/1/7 25+
  String get customerId => pk!.split("\$")[2];
  String get hotelId => pk!.split("\$")[1];
  String get documentType => pk!.split(sp)[4];
  String get documentId => pk!.split(sp)[6];
  String get nationCode => pk!.split(sp)[5];
}