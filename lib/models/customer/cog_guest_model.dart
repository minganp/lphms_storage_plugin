import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/models/customer/customer_model.dart';
import 'package:lphms_storage_plugin/utility/record_prefix.dart';

import 'aws_auth_user_attr.dart';

class CogGuestModel {
  AuthUser? user;
  List<AuthUserAttribute> guestAttributes = [];

  setAttrsWithList(List<Map<String,String>> attributesList){
    guestAttributes = [];
    for (var element in attributesList) {
      guestAttributes.add(
          AuthUserAttribute(
              userAttributeKey: CognitoUserAttributeKey.custom(element.keys.first),
              value: element.values.first
          )
      );
    }
  }

  setCustomAttrsWithMap(Map<String,String> customAttr){
    for (var element in customAttr.entries) {
      guestAttributes.add(
          AuthUserAttribute(
              userAttributeKey: CognitoUserAttributeKey.custom(element.key),
              value: element.value
          )
      );
    }
  }
  setCustomAttr(AuthUserAttributeKey key,String value){
    guestAttributes.add(
        AuthUserAttribute(
            userAttributeKey: key,
            value: value
        )
    );
  }
  CogGuestModel({required this.user, required this.guestAttributes});
}

extension GuestAttribute on CustomerInfo {

  List<AuthUserAttribute> toGuestAttributes() {
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
      const CognitoUserAttributeKey.custom(GuestCogKey.iUrP): iUrP,
      const CognitoUserAttributeKey.custom(GuestCogKey.iUrL): iUrL,
      const CognitoUserAttributeKey.custom(GuestCogKey.iUrO): iUrO,
    };
    for (var element in attributes.entries) {
      guestAttributes.add(AuthUserAttribute(
          userAttributeKey: element.key, value: element.value));
    }
    return guestAttributes;
  }

  fromGuestModel(CogGuestModel guestModel) {
    if(guestModel.guestAttributes.isEmpty)return null;
    for (var element in guestModel.guestAttributes) {
      print("getAttributeKeyName:${element.userAttributeKey.key}:${element.value}");
      switch (element.userAttributeKey.key) {
        case GuestCogKey.sub:
          sub = element.value;
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
        case GuestCogKey.iUrP:
          iUrP = element.value;
          break;
        case GuestCogKey.iUrO:
          iUrO = element.value;
          break;
        case GuestCogKey.iUrL:
          iUrL = element.value;
          break;
        default:
          continue;
      }
    }
  }
}
