import 'package:amplify_api/amplify_api.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/dao/response_message.dart';
import 'package:lphms_storage_plugin/models/customer/customer_change_log.dart';

import '../../models/customer/customer_model.dart';

class CustomerStoreService{
  //create new customer
  static Future<ResponseMessage> saveCustomer(CustomerInfo customerInfo) async {
    try {
      final request = ModelMutations.create(customerInfo.toLHMS());
      final response = await Amplify.API
          .mutate(
        request: request,)
          .response;
      final operation = response.data;
      if (operation == null) {
        return ResponseMessage(
            status: 'fail',
            message: 'Error: ${response.errors}', data: response.errors);
      }
      return ResponseMessage(
          status: 'success',
          message: 'Create new customer successfully', data: response.data);
    } on ApiException catch (e) {
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: e.toString());
    }
  }
   /*       Amplify.API.mutate(
          request: GraphQLRequest(
              document: sCustomer,
              variables: {
                'input': {
                  'pk': customerInfo.pk,
                  'sk': customerInfo.pk,
                  'sna': customerInfo.sna,
                  'gna': customerInfo.gna,
                  'isr': customerInfo.isr,
                  'dob': customerInfo.dob,
                  'doe': customerInfo.doe,
                  'sex': customerInfo.sex,
                  'nna': customerInfo.nt
              }}
          )).response;
      response = await operation;
      if(response.data == null){
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

  }*/

  static Future<ResponseMessage> updateCustomer(CustomerInfo customerInfo) async{
    try{
      final request = ModelMutations.update(customerInfo.toLHMS());
      final response = await Amplify.API.mutate(request: request).response;
      final updated = response.data;
      if(updated == null){
        ResponseMessage(
            status: 'fail',
            message: 'Error: ${response.errors}', data: response.errors);
      }
      return ResponseMessage(
          status: 'success',
          message: 'Update customer successfully', data: response.data);
    }on ApiException catch(e){
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: e.toString());
    }
  }

  static Future<ResponseMessage> customerChangeLog(CustomerChangeLog changeLog) async{
    try{
      final request = ModelMutations.create(changeLog.toLHMS());
      final response = await Amplify.API.mutate(request: request).response;
      final updated = response.data;
      if(updated == null){
        ResponseMessage(
            status: 'fail',
            message: 'Error: ${response.errors}', data: response.errors);
      }
      return ResponseMessage(
          status: 'success',
          message: 'Update customer successfully', data: response.data);
    }on ApiException catch(e){
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: e.toString());
    }
  }
}