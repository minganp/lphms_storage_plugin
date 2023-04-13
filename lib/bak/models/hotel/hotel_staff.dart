import 'dart:core';

import 'package:lphms_storage_plugin/function/uuid_generator.dart';
import 'package:lphms_storage_plugin/models/ModelProvider.dart';
import 'package:lphms_storage_plugin/utility/position_enum.dart';
import 'package:lphms_storage_plugin/utility/record_prefix.dart';

class HotelStaff {
   String? pk;   //hotelId
   String? sk;     //staff id:  ST#<staffID>
   String? sna;   //surname
   String? gna;  //given name
   String? mph;  //mobile phone
   String? hsp;  //position of the staff -RECEPTION -ADMIN -DEACTIVATE
   String? cac;  //cognito account
   int? avl;

   HotelStaff({required this.pk, this.sk,this.cac,this.sna,this.gna,this.mph,this.hsp,this.avl});

   HotelStaff.create({required String hotelId,required String surname,
     String? givenName, String? mobile, required String position, String? account}){
    pk = hotelId;
    sk = "${rPref[RecType.hotelStaff]}#${generateStaffId()}";
    sna = surname;
    gna = givenName;
    mph = mobile;
    hsp = position;
    cac = account;
    avl = 0;
   }

   HotelStaff.fromLHMS(LHMS lhms){
     pk = lhms.PK;
     sk = lhms.SK;
     sna = lhms.sna;
     gna = lhms.gna;
     mph = lhms.mph;
     hsp = lhms.hsp;
     cac = lhms.cac;
     avl = lhms.avl;
   }

    LHMS toLHMS(){
      return LHMS(PK: pk!, SK: sk!, sna: sna, gna: gna, mph: mph, hsp: hsp, cac: cac, avl: avl);
    }

    String toStr(){
      return "Surname: $sna, Given name: $gna, Mobile: $mph, Position: $hsp, Account: $cac, avl: $avl";
    }
}