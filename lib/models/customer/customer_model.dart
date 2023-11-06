


import 'package:amplify_flutter/amplify_flutter.dart';

import '../../../models/LHMS.dart';
import '../../../utility/record_prefix.dart';
import '../change_log/changeLog.dart';
import 'aws_auth_user_attr.dart';

class CustomerInfo{
   String? sub;     //cognito user id. No attribute in LHMS
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
   String? iUrP; //passport picture url in s3
   String? iUrL; //ID picture of Laos url in s3
   String? iUrO; //Other id document picture in s3
   String? nt; //nation

   //customer id : CU_<Document Type>_<Nation Code>_<Document ID>
   final _cuInfoPattern = r"CU_(\w+)_(\w+)_([\w\d]+)";

   //nation Id: NT_<Nation Code>
   final _cuNcPattern = r"NT_(\w+)";

   CustomerInfo({ this.sub,this.pk,this.docID, this.docType, this.sna, this.gna, this.isr, this.dob, this.sex, this.doe,this.nt, this.isd,this.iUrP,this.iUrL,this.iUrO});
   CustomerInfo.createFromProfile({ required this.docID, required this.docType, this.sna, this.gna, this.isr, this.dob, this.sex, this.doe,required this.nt,required this.isd,String? url,this.sub}){
      pk = genPk();
      docImgUrl = url;
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
      iUrP = info.iUrP;
      iUrL = info.iUrL;
      iUrO = info.iUrO;
      nt = getNcFromPK();
   }

   String toJsonString() => "{pk:$pk,sna:$sna,gna:$gna,isr:$isr,dob:$dob,sex:$sex,doe:$doe,nt:$nt, isd:$isd, iur: ${iUrP.toString()}, sub: $sub,docType: $docType,docID: $docID}";
   String genPk() => "${rPref[RecType.customer]}_${docType}_${nt}_$docID";

   bool get isProfileComplete => pk!=null && docID!=null && docType!=null && nt!=null && (iUrO!=null || iUrL !=null || iUrP !=null);
   bool get isProfileFullyComplete => pk!=null && docID!=null && docType!=null && nt!=null && (iUrO!=null || iUrL !=null || iUrP !=null);

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
            case GuestCogKey.sub:
               sub= element.value;
               print('set sub: $sub');
               break;
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
            case GuestCogKey.iUrO:
               iUrO = element.value;
               break;
            case GuestCogKey.iUrP:
               iUrP = element.value;
               break;
            case GuestCogKey.iUrL:
               iUrL = element.value;
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
         AuthUserAttributeKey.sub: sub!,
         const CognitoUserAttributeKey.custom(GuestCogKey.issuer): isr,
         AuthUserAttributeKey.birthdate: dob.toString(),
         AuthUserAttributeKey.gender: sex!,
         const CognitoUserAttributeKey.custom(GuestCogKey.expireDate): doe.toString(),
         const CognitoUserAttributeKey.custom(GuestCogKey.nationality): nt,
         const CognitoUserAttributeKey.custom(GuestCogKey.cinPk): "${rPref[RecType.selfCheckInRec]}_${pk!}",
         const CognitoUserAttributeKey.custom(GuestCogKey.issueDate): isd.toString(),
         const CognitoUserAttributeKey.custom(GuestCogKey.iUrO): iUrO,
          const CognitoUserAttributeKey.custom(GuestCogKey.iUrP): iUrP,
          const CognitoUserAttributeKey.custom(GuestCogKey.iUrL): iUrL,
      };
      for (var element in attributes.entries) {
         if(element.value!=null) {
            guestAttributes.add(AuthUserAttribute(
                userAttributeKey: element.key, value: element.value));
         }
      }
      return guestAttributes;
   }

  String? get urlByDocType{

      switch(docType){
         case "P":
            return iUrP;
         case "I":
            return iUrL;
         case "O":
            return iUrO;
         default:
            return null;
      }
   }
   set docImgUrl(String? url){
      switch(docType){
         case "P":
            iUrP = url;
            break;
         case "I":
            iUrL = url;
            break;
         case "O":
            iUrO = url;
            break;
         default:
            break;
      }
   }
   LHMS toLHMS(){
      LHMS lhms = LHMS(
         PK: genPk(), SK: genPk(), sna: sna, gna: gna, isr: isr, dob: dob, sex: sex, doe: doe,nna: nt, iUrP: iUrP,iUrO: iUrO,iUrL: iUrL
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
