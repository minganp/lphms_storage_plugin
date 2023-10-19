//import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
/*
typedef CustomerKeyType = String;
extension CK on CustomerKeyType {
   get key => CognitoUserAttributeKey.custom(this);
}
 */
class GuestCogKey {
  static const String familyName = "family_name";
  static const String givenName = "given_name";
  static const String birthdate = "birthdate";
  static const String gender = "gender";
  static const String cinPk = "custom:cinPk";
  static const String pkCKey = "custom:pk";
  static const String docId = "custom:docid";
  static const String docType = "custom:docType";
  static const String issuer = "custom:docIssuer";
  static const String expireDate = "custom:issueedate";
  static const String issueDate = "custom:issuedate";
  static const String nationality = "custom:nationality";
  /*
    cognito already has a guest attribute:
     id
     given_name
     family_name(surname)
     gender
     birthday
     email
   */
  /*
  static const CustomerKeyType pkCKey = "custom:pk";
  static const CustomerKeyType docIdCKey = "custom:docId";
  static const CustomerKeyType docTypeCKey = "custom:docType";
  static const CustomerKeyType issuerCKey = "custom:docIssuer";
  static const CustomerKeyType isExpireDateCKey = "custom:issueEDate";
  static const CustomerKeyType nationalityCKey = "custom:nationality";

   */
  /*
  //passport
  static const CustomerKeyType expireDateKey1 = "custom:expireDate1";
  static const CustomerKeyType nationKeyName = "custom:nationality1";
  static const CustomerKeyType docTypeKey1 = "custom:docType1";
  static const CustomerKeyType docIdKey1 = "custom:docId1";
  static const CustomerKeyType issuer1 = "custom:issuer1";
  static const CustomerKeyType issueDateKey1 = "custom:issueDate1";
  //id card
  static const CustomerKeyType expireDateKey2 = "custom:expireDate2";
  static const CustomerKeyType nationKey2 = "custom:nationality2";
  static const CustomerKeyType docTypeKey2 = "custom:docType2";
  static const CustomerKeyType docIdKey2 = "custom:docId2";
  static const CustomerKeyType issuer2 = "custom:issuer2";
  static const CustomerKeyType issueDateKey2 = "custom:issueDate2";
  //other: driver license, etc
  static const CustomerKeyType expireDateKey3 = "custom:expireDate3";
  static const CustomerKeyType nationKey3 = "custom:nationality3";
  static const CustomerKeyType docTypeKey3 = "custom:docType3";
  static const CustomerKeyType docIdKey3 = "custom:docId3";
  static const CustomerKeyType issuer3 = "custom:issuer3";
  static const CustomerKeyType issueDateKey3 = "custom:issueDate3";
  */
}
