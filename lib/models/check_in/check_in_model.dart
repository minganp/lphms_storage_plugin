import 'package:amplify_flutter/amplify_flutter.dart';
//import 'package:lphms_storage_plugin/utility/position_enum.dart';
//import 'package:lphms_storage_plugin/utility/record_prefix.dart';

import '../../../models/LHMS.dart';
import '../../../utility/position_enum.dart';
import '../../../utility/record_prefix.dart';

class CheckInRecord{
  String? pk; //CR#<hotel Id>
  String? sk; //customer id
  String? gis1; //check in date
  TemporalDateTime? cod; //check out date
  TemporalDateTime? cid; //check in date;
  String? rno; //room number
  int? ihs;

  CheckInRecord.create({
    required String hotelId,
    required String customerId,
    required TemporalDateTime checkInDate,
    required TemporalDateTime checkOutDate,
}){
    pk = "${rPref[RecType.checkInRecord]}#$hotelId";
    sk = customerId;
    gis1 = checkInDate.format();
    cid = checkInDate;
    cod = checkOutDate;
    rno = rno;
    ihs = ihs;
}
  CheckInRecord.fromLHMS(LHMS lhms){
    pk = lhms.PK;
    sk = lhms.SK;
    gis1 = lhms.GSI1;
    cod = lhms.cod;
    cid = lhms.cid;
    rno = lhms.rno;
    ihs = lhms.ihs;
  }
  LHMS toLHMS(){
    return LHMS(PK: pk!, SK: sk!, GSI1: gis1, cod: cod, cid: cid,rno: rno, ihs: ihs);
  }
}