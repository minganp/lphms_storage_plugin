


import 'package:amplify_flutter/amplify_flutter.dart';

import '../../../models/LHMS.dart';
import '../../../utility/position_enum.dart';
import '../../../utility/record_prefix.dart';
import '../change_log/changeLog.dart';

class CustomerInfo{
   String? pk;      //customerId
   String? docID;
   String? docType;
   String? sna;
   String? gna;
   String? isr;
   TemporalDate? dob;
   String? sex;
   TemporalDate? doe;
   String? nt; //nation

   //customer id : CU_<Document Type>_<Nation Code>_<Document ID>
   final _cuInfoPattern = r"CU_(\w+)_(\w+)_([\w\d]+)";

   //nation Id: NT_<Nation Code>
   final _cuNcPattern = r"NT_(\w+)";

   CustomerInfo({ this.pk,this.docID, this.docType, this.sna, this.gna, this.isr, this.dob, this.sex, this.doe,this.nt});
   CustomerInfo.profile({ required this.docID, required this.docType, this.sna, this.gna, this.isr, this.dob, this.sex, this.doe,required this.nt}){
      pk = genPk();
   }

   CustomerInfo.fromLHMS(LHMS info){
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
   }

   String toJsonString() => "{pk:$pk,sna:$sna,gna:$gna,isr:$isr,dob:$dob,sex:$sex,doe:$doe,nt:$nt}";
   String genPk() => "${rPref[RecType.customer]}_${docType}_${nt}_$docID";

   bool get isProfileComplete => pk!=null && docID!=null && docType!=null && nt!=null;
   bool get isProfileFullyComplete => pk!=null && docID!=null && docType!=null && nt!=null;

   //get doc id from pk
   String? getDocIdFromPK() =>
      RegExp(_cuInfoPattern).firstMatch(pk!)?.group(3);

   //get nation code from pk
   String? getNcFromPK() =>
       RegExp(_cuInfoPattern).firstMatch(pk!)?.group(2);

   //get doc type from pk
   String? getDocTypeFromPK() =>
       RegExp(_cuInfoPattern).firstMatch(pk!)?.group(1);

   LHMS toLHMS(){
      LHMS lhms = LHMS(
         PK: genPk(), SK: genPk(), sna: sna, gna: gna, isr: isr, dob: dob, sex: sex, doe: doe,nna: nt
      );
      return lhms;
   }
   LHMS toLHMSCuNt1(){
      LHMS lhms = LHMS(
         PK: genPk(), SK: "${rPref[RecType.nation]}$sp$nt"
      );
      return lhms;
   }

   LHMS toLog(String logTag) =>
      ChangeLog(pk: pk!,logTag: logTag, logMsg: toJsonString()).toLHMS();

}
