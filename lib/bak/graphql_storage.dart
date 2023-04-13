import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/models/LHMS.dart';

import '../futures/dao/interface_storage.dart';

class GraphqlStore implements ILhmsStorage {
  Future<void> create<T>(Model T,) async {
    try {
      final request = ModelMutations.create(T);
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      final created = response.data;
      if (created == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${T.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }
  }

  @override
  Future<LHMS> queryLhms({required String pk, required String sk}) {
    // TODO: implement queryLhms
    try{
      final request = ModelQueries.get(LHMS.classType,queried)
    }
  }

  @override
  Future saveLhms(LHMS lhms) async{
    // TODO: implement saveLhms
    try {
      final request = ModelMutations.create(lhms);
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      final created = response.data;
      if (created == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${lhms.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }  }

  @override
  Future updateLhms(LHMS lhms) async{
    // TODO: implement updateLhms
    try {
      final request = ModelMutations.update(lhms);
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      print("Response: $response");
    }on ApiException catch(e){
      safePrint('Update failed $e');
    }
  }

}