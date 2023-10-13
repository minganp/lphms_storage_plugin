//import 'package:lphms_storage_plugin/models/ModelProvider.dart';


import 'package:lphms_storage_plugin/dao/response_message.dart';

import '../../models/LHMS.dart';

abstract class ILhmsStorage{
  Future<ResponseMessage> saveLhms({required LHMS lhms});
  Future<ResponseMessage> updateLhms({required LHMS lhms});
  Future<ResponseMessage> queryLhms({required String script, required Map<String,dynamic> args});

}
