
import 'package:lphms_storage_plugin/models/customer/customer_model.dart';

import '../../utility/position_enum.dart';
import '../../utility/record_prefix.dart';
import '../../models/LHMS.dart';
import 'customer_change_log.dart';

class CustomerGeneralInfo {
  CustomerInfo customerInfo;
  List<CustomerChangeLog> changeLogs = [];

  CustomerGeneralInfo({
    required this.customerInfo,
    this.changeLogs = const [],
  });

  factory CustomerGeneralInfo.fromLHMS(List<dynamic> info){
    List<CustomerChangeLog> changeLogs = [];
    late CustomerInfo customerInfo ;
    for (var element in info) {
      if(element == null) continue;
      var lhms = LHMS.fromJson(element);
      if(lhms.SK.startsWith(rPref[RecType.changeLog]!)){
        changeLogs.add(CustomerChangeLog.fromLHMS(lhms));
      }else if(lhms.SK.startsWith(rPref[RecType.customer]!)){
        customerInfo = CustomerInfo.fromLHMS(element);
      }
    }
    return CustomerGeneralInfo(
      customerInfo: customerInfo,
      changeLogs: changeLogs,
    );
  }
}