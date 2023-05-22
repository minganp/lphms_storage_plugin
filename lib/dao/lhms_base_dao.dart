import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/dao/response_message.dart';

import '../models/LHMS.dart';

class LhmsBaseDao {
  static Future<ResponseMessage> writeNewRecLHMS(LHMS lhms) async {
    ResponseMessage responseMessage;
    try {
      final request = ModelMutations.create(lhms);
      final response = await Amplify.API.mutate(request: request).response;
      response.hasErrors
          ? responseMessage = ResponseMessage(
              status: 'fail',
              message: 'Write mew LHMS has errors',
              data: response.errors.toString())
          : responseMessage = ResponseMessage(
              status: 'success', message: '', data: response.data);
    } on ApiException catch (e) {
      return responseMessage = ResponseMessage(
          status: 'fail',
          message: 'Write mew LHMS has errors',
          data: e.toString());
    }
    return responseMessage;
  }

  static Future<ResponseMessage> updateRecLHMS(LHMS lhms) async {
    ResponseMessage responseMessage;
    try {
      final request = ModelMutations.update(lhms);
      final response = await Amplify.API.mutate(request: request).response;
      response.hasErrors
          ? responseMessage = ResponseMessage(
              status: 'fail',
              message: 'Update LHMS has errors',
              data: response.errors.toString())
          : responseMessage = ResponseMessage(
              status: 'success', message: '', data: response.data);
    } on ApiException catch (e) {
      return responseMessage = ResponseMessage(
          status: 'fail',
          message: 'Update LHMS has errors',
          data: e.toString());
    }
    return responseMessage;
  }
}
