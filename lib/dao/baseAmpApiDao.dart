import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/dao/response_message.dart';
import 'package:lphms_storage_plugin/models/LHMS.dart';

import 'interface_storage.dart';

class BaseAmpApiDao implements ILhmsStorage{
  @override
  Future<ResponseMessage> queryLhms({required String script, required Map<String,dynamic> args}) async{
    GraphQLRequest request = GraphQLRequest(
        document: script,
        variables: args,
        authorizationMode: APIAuthorizationType.userPools,
    );
    try{
      final response = await Amplify.API.query(request: request).response;
      final operation = response.data;
      var lhmsJson;
      print(response);
      if(operation == null){
        return ResponseMessage(
            status: 'fail',
            message: 'Error: ${response.errors}', data: response.errors);
      }
      try{
        lhmsJson = jsonDecode(response.data);
      }on FormatException catch(e){
        return ResponseMessage(
            status: 'fail',
            message: 'Error: Result Bad format', data: e.toString());
      }
      print(" queryLhms $lhmsJson");
      if(lhmsJson['getLHMS'] == {} || lhmsJson['getLHMS'] == null){
        return ResponseMessage(
            status: 'fail',
            message: 'Error: LHMS Result Null', data: response.errors);
      }
      var lhms = lhmsJson['getLHMS'];
      return ResponseMessage(
          status: 'success',
          message: 'Create new customer successfully', data: lhms);

    }on ApiException catch(e){
      print("exception");
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: e.toString());
    }
  }

  @override
  Future<ResponseMessage> saveLhms({required LHMS lhms}) async{
    // TODO: implement saveLhms
    try{
      final request = ModelMutations.create(lhms);
      final response = await Amplify.API.mutate(request: request).response;
      final operation = response.data;
      if(operation == null){
        return ResponseMessage(
            status: 'fail',
            message: 'Error: ${response.errors}', data: response.errors);
      }
      return ResponseMessage(
          status: 'success',
          message: 'Create new customer successfully', data: response.data);
    }on ApiException catch(e){
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: e.toString());
    }
  }

  @override
  Future<ResponseMessage> updateLhms({required LHMS lhms}) async{
    // TODO: implement updateLhms
    try{
     final request = ModelMutations.update(lhms);
      final response = await Amplify.API.mutate(request: request).response;
      final operation = response.data;
      if(operation == null){
        return ResponseMessage(
            status: 'fail',
            message: 'Error: ${response.errors}', data: response.errors);
      }
      return ResponseMessage(
          status: 'success',
          message: 'Create new customer successfully', data: response.data);
    }on ApiException catch(e){
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: e.toString());
    }
  }
}