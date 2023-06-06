


import 'package:amplify_flutter/amplify_flutter.dart';

import '../../../models/LHMS.dart';
import '../../../utility/position_enum.dart';
import '../../../utility/record_prefix.dart';
import '../change_log/changeLog.dart';

class CustomerInfo{
   String? pk;
   String? docID;
   String? docType;
   String? sna;
   String? gna;
   String? isr;
   TemporalDate? dob;
   String? sex;
   TemporalDate? doe;
   String? nt; //nation

   //customer id : CU#<Document Type>#<Nation Code>#<Document ID>
   final _cuInfoPattern = r"CU#(\w+)#(\w+)#([\w\d]+)";

   //nation Id: NT#<Nation Code>
   final _cuNtPattern = r"NT#(\w+)";

   CustomerInfo({ this.docID, this.docType, this.sna, this.gna, this.isr, this.dob, this.sex, this.doe});

   String toJsonString() => "{pk:$pk,sna:$sna,gna:$gna,isr:$isr,dob:$dob,sex:$sex,doe:$doe}";
   String genPk() => "${rPref[RecType.customer]}#$docType#$docID#$docID";

   String? getDocIdFromPK() =>
      RegExp(_cuInfoPattern).firstMatch(pk!)?.group(3);

   String? getNtFromPK() =>
       RegExp(_cuInfoPattern).firstMatch(pk!)?.group(2);

   String? getDocTypeFromPK() =>
       RegExp(_cuInfoPattern).firstMatch(pk!)?.group(1);

   LHMS toLHMS(){
      LHMS lhms = LHMS(
         PK: genPk(), SK: genPk(), sna: sna, gna: gna, isr: isr, dob: dob, sex: sex, doe: doe
      );
      return lhms;
   }
   LHMS toLHMSCuNt1(){
      LHMS lhms = LHMS(
         PK: genPk(), SK: "${rPref[RecType.nation]}#$nt"
      );
      return lhms;
   }

   LHMS toLog(String logTag) =>
      ChangeLog(pk: pk!,logTag: logTag, logMsg: toJsonString()).toLHMS();

}
