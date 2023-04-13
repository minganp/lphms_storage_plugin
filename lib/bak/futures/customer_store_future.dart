import 'package:lphms_storage_plugin/models/customer/customer_model.dart';

import '../models/LHMS.dart';
import 'dao/interface_storage.dart';

class CustomerStorage {
  ILhmsStorage storage;

  CustomerStorage(this.storage);

  Future createCustomer(CustomerInfo customerInfo) async{
    //for create new customer, the customerInfo don't include pk,
    //should generate by call genPk.
    customerInfo.pk = customerInfo.genPk();
    await storage.saveLhms(customerInfo.toLHMS());
    //save nation code
    await storage.saveLhms(customerInfo.toLHMSCuNt1());

    //save change log
    await storage.saveLhms(customerInfo.toLog("Create"));
  }

  Future updateCustomer(CustomerInfo customerInfo) async {
    LHMS lhms = await storage.queryLhms(pk:customerInfo.pk!,sk: customerInfo.pk!);
    lhms.copyWith(
      sna: customerInfo.sna,gna: customerInfo.gna,sex: customerInfo.sex,
      doe: customerInfo.doe,dob: customerInfo.doe,isr: customerInfo.isr,
    );
    await storage.saveLhms(lhms);

    await storage.saveLhms(customerInfo.toLog("Update"));
  }

}