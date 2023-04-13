//import 'package:lphms_storage_plugin/models/ModelProvider.dart';


import '../../models/LHMS.dart';

abstract class ILhmsStorage{
  Future saveLhms(LHMS lhms);
  Future updateLhms(LHMS lhms);
  Future queryLhms({required String pk, required String sk});
}
