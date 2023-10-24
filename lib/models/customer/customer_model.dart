


import 'package:amplify_flutter/amplify_flutter.dart';

import '../../../models/LHMS.dart';
import '../../../utility/record_prefix.dart';
import '../change_log/changeLog.dart';
import 'aws_auth_user_attr.dart';

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
   TemporalDate? isd; //issue date
   List<String?>? iUr;
   String? nt; //nation

   //customer id : CU_<Document Type>_<Nation Code>_<Document ID>
   final _cuInfoPattern = r"CU_(\w+)_(\w+)_([\w\d]+)";

   //nation Id: NT_<Nation Code>
   final _cuNcPattern = r"NT_(\w+)";

   CustomerInfo({ this.pk,this.docID, this.docType, this.sna, this.gna, this.isr, this.dob, this.sex, this.doe,this.nt, this.isd,this.iUr});
   CustomerInfo.profile({ required this.docID, required this.docType, this.sna, this.gna, this.isr, this.dob, this.sex, this.doe,required this.nt,required this.isd,this.iUr}){
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
      isd = info.isd;
      iUr = info.iUr;
      nt = getNcFromPK();
   }

   String toJsonString() => "{pk:$pk,sna:$sna,gna:$gna,isr:$isr,dob:$dob,sex:$sex,doe:$doe,nt:$nt, isd:$isd, iUr: ${iUr.toString()}";
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

   propFromGuestModel(List<AuthUserAttribute> attributes) {
      if(attributes.isEmpty)return;
      for (var element in attributes) {
         print("getAttributeKeyName:${element.userAttributeKey.key}:${element.value}");
         switch (element.userAttributeKey.key) {
            case GuestCogKey.pkCKey:
               pk = element.value;
               break;
            case GuestCogKey.docId:
               docID = element.value;
               break;
            case GuestCogKey.docType:
               docType = element.value;
               break;
            case GuestCogKey.familyName:
               sna = element.value;
               break;
            case GuestCogKey.givenName:
               gna = element.value;
               break;
            case GuestCogKey.issuer:
               isr = element.value;
               break;
            case GuestCogKey.birthdate:
               dob = TemporalDate.fromString(element.value);
               break;
            case GuestCogKey.gender:
               sex = element.value;
               break;
            case GuestCogKey.expireDate:
               doe = TemporalDate.fromString(element.value);
               break;
            case GuestCogKey.issueDate:
               isd = TemporalDate.fromString(element.value);
               break;
            case GuestCogKey.nationality:
               nt = element.value;
               break;
            default:
               continue;
         }
      }
   }

   List<AuthUserAttribute> toCogGuestAttributes() {
      List<AuthUserAttribute> guestAttributes = [];

      GuestCogKey.pkCKey;
      final Map<AuthUserAttributeKey, dynamic> attributes = {
         const CognitoUserAttributeKey.custom(GuestCogKey.pkCKey): pk,
         const CognitoUserAttributeKey.custom(GuestCogKey.docId): docID,
         const CognitoUserAttributeKey.custom(GuestCogKey.docType): docType,
         AuthUserAttributeKey.familyName: sna!,
         AuthUserAttributeKey.givenName: gna!,
         const CognitoUserAttributeKey.custom(GuestCogKey.issuer): isr,
         AuthUserAttributeKey.birthdate: dob.toString(),
         AuthUserAttributeKey.gender: sex!,
         const CognitoUserAttributeKey.custom(GuestCogKey.expireDate): doe.toString(),
         const CognitoUserAttributeKey.custom(GuestCogKey.nationality): nt,
         const CognitoUserAttributeKey.custom(GuestCogKey.cinPk): "${rPref[RecType.selfCheckInRec]}_${pk!}",
         const CognitoUserAttributeKey.custom(GuestCogKey.issueDate): isd.toString()
      };
      for (var element in attributes.entries) {
         guestAttributes.add(AuthUserAttribute(
             userAttributeKey: element.key, value: element.value));
      }
      return guestAttributes;
   }

   LHMS toLHMS(){
      LHMS lhms = LHMS(
         PK: genPk(), SK: genPk(), sna: sna, gna: gna, isr: isr, dob: dob, sex: sex, doe: doe,nna: nt, iUr: iUr
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
