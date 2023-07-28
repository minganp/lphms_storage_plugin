

import 'package:lphms_storage_plugin/models/LHMS.dart';

import '../../utility/position_enum.dart';
import '../../utility/record_prefix.dart';

class CustomerChangeLog{
  String? pk; //customerId
  String? sk; //change log id:  CL#<datetime>#<actions>
  String? clg; //change login string
  String? action;

  CustomerChangeLog({
    required this.pk,
    this.sk,
    this.clg,
  });

  CustomerChangeLog.create(
    {required String customerId,
    required String changeLogId,
    required String changeLogStr}) {
    pk = customerId;
    sk = "${rPref[RecType.changeLog]}#${DateTime.now()}#$action";
    clg = changeLogStr;
  }

  CustomerChangeLog.fromLHMS(LHMS lhms) {
    pk = lhms.PK;
    sk = lhms.SK;
    clg = lhms.clg;
  }
  LHMS toLHMS() {
    return LHMS(
      PK: pk!,
      SK: sk!,
      clg: clg,
    );
  }
  String toStr() {
    return "Change date: ${sk!.split('#')[1]}, Action: ${sk!.split('#')[2]}, Change log: $clg";
  }
}