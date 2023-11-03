
enum DocType{
  P,
  I,
  O,
}
//character of doc type
Map<DocType,dynamic> docTypeC = {
  DocType.P:{"Char":"P","Full":"Passport","File":"idPass.png"},
  DocType.I:{"Char":"I", "Full":"ID", "File":"idDoc.png"},
  DocType.O:{ "Char":"O", "Full":"Other", "File":"idOther.png"},
};

get docTypeChar => docTypeC[DocType.P]!['Char'];
get docTypeFull => docTypeC[DocType.P]!['Full'];
get docTypeFile => docTypeC[DocType.P]!['File'];
