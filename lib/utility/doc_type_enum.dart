
import 'package:lphms_storage_plugin/models/customer/aws_auth_user_attr.dart';

enum DocType{
  P,
  I,
  O,
}
//character of doc type
Map<DocType,dynamic> docTypeC = {
  DocType.P:{"Char":"P","Name":"Passport","ImgFile":"idPass.png","CogKeyName":GuestCogKey.iUrP,},
  DocType.I:{"Char":"I", "Name":"ID", "ImgFile":"idDoc.png","CogKeyName":GuestCogKey.iUrL,},
  DocType.O:{"Char":"O", "Name":"Other", "ImgFile":"idOther.png","CogKeyName":GuestCogKey.iUrO,},
};
DocType getDocTypeFromChar(String char) => docTypeC.keys.firstWhere((e) => docTypeC[e]!['Char'] == char);
DocType getDocTypeFromName(String name) => docTypeC.keys.firstWhere((e) => docTypeC[e]!['Name'] == name);

String docTypeChar(DocType type) => docTypeC[type]!['Char'];
String docTypeName(DocType type) => docTypeC[type]!['Name'];
String docTypeFile(DocType type) => docTypeC[type]!['ImgFile'];
docTypeCogKey(DocType type) => docTypeC[type]!['CogKeyName'];
extension DocUtilities on DocType{
  String get char => docTypeChar(this);
  String get name => docTypeName(this);
  String get file => docTypeFile(this);
  String get cogKeyName => docTypeCogKey(this);
}
