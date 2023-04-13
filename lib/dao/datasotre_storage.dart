import 'package:amplify_flutter/amplify_flutter.dart';
//import 'package:lphms_storage_plugin/models/LHMS.dart';

import '../../models/LHMS.dart';
import 'interface_storage.dart';

class DataStoreStorage implements ILhmsStorage{
  @override
  Future queryLhms({required String pk, required String sk}) async {
    // TODO: implement queryLhms
    LHMS qu = (await Amplify.DataStore.query(
        LHMS.classType,
        where: LHMS.QPK.eq(pk).and(LHMS.QSK.eq(sk))))[0];
    return qu;
  }

  @override
  Future saveLhms(LHMS lhms) async{
    // TODO: implement saveLhms
    await Amplify.DataStore.save(lhms);
  }

  @override
  Future updateLhms(LHMS lhms) async{
      throw UnimplementedError();
  }

}