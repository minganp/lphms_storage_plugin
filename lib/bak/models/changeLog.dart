import 'package:intl/intl.dart';
import 'package:lphms_storage_plugin/utility/position_enum.dart';
import 'package:lphms_storage_plugin/utility/record_prefix.dart';

import 'LHMS.dart';

class ChangeLog{
  late String pk;
  late String sk;
  late String clg;

  ChangeLog({required String pk,required logTag,required logMsg}){
    String date = DateFormat.yMd().format(DateTime.now());
    pk = pk;
    sk = "${rPref[RecType.changeLog]}#$date#$logTag";
    clg = "{date:${DateTime.now()},Msg:{$clg}";
  }

  LHMS toLHMS() =>
    LHMS(PK: pk, SK: sk, clg: clg);

}