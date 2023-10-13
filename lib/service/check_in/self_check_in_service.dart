
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/dao/baseAmpApiDao.dart';
import 'package:lphms_storage_plugin/dao/interface_storage.dart';
import 'package:lphms_storage_plugin/models/check_in/check_in_model.dart';
import 'package:lphms_storage_plugin/models/hotel/hotel_model.dart';

import '../../dao/response_message.dart';
import '../../models/LHMS.dart';
import '../../models/check_in/self_check_in_model.dart';
import '../../models/customer/customer_model.dart';

class SelfCheckInService {
  static Future<ResponseMessage> selfCheckIn({
    required HotelInfo hotelInfo,
    required CustomerInfo customerInfo,
  }) async {
    var selfCheckInModel = SelfCheckInModel.create(
        hotelInfo: hotelInfo,
        customerInfo: customerInfo,
        gsi: "0"
    );
    ILhmsStorage lhmsStorage = BaseAmpApiDao();
    var responseMsg = await lhmsStorage.saveLhms(
        lhms: selfCheckInModel.toLHMS());
    return responseMsg;
  }

  static Future<ResponseMessage> selfCancelCheckIn({
    required HotelInfo hotelInfo,
    required CustomerInfo customerInfo,
    required String? gsi, //gsi1 =null means checked in or cancelled
  }) async {
    var selfCheckInModel = SelfCheckInModel.create(
        hotelInfo: hotelInfo,
        customerInfo: customerInfo,
        gsi: null
    );
    ILhmsStorage lhmsStorage = BaseAmpApiDao();
    var responseMsg = await lhmsStorage.updateLhms(
        lhms: selfCheckInModel.toLHMS());
    return responseMsg;
  }

  static Future<ResponseMessage> hotelCheckIn ({
    required SelfCheckInModel scm,
    required TemporalDateTime cid,
    required String rno,
  })async{
    ILhmsStorage lhmsStorage = BaseAmpApiDao();
    CheckInRecord checkInRecord = scm.toCheckInModel(cid: cid, rno: rno);
    ResponseMessage responseMessage = await lhmsStorage.saveLhms(
        lhms: checkInRecord.toLHMS(), );
    return responseMessage;
  }
  static Future<ResponseMessage> hotelCheckOut(
      CheckInRecord checkInRecord,
      TemporalDateTime cod,
      )async{
      ILhmsStorage lhmsStorage = BaseAmpApiDao();
      checkInRecord.ihs = null;
      checkInRecord.cod = cod;
      ResponseMessage responseMessage = await lhmsStorage.updateLhms(
          lhms: checkInRecord.toLHMS(), );
      return responseMessage;
  }
  //??do not use?????
  static Future<ResponseMessage> hotelCancelSCMCheckIn({
    required SelfCheckInModel scm,
}) async{
    ILhmsStorage lhmsStorage = BaseAmpApiDao();
    scm.gsi1 = null;
    ResponseMessage responseMessage = await lhmsStorage.updateLhms(
        lhms: scm.toLHMS(), );
    return responseMessage;
}

  //??do not use?????
  static Future<ResponseMessage> hotelCancelCheckIn(CheckInRecord checkInRecord)async{
    ILhmsStorage lhmsStorage = BaseAmpApiDao();
    checkInRecord.ihs = null;
    ResponseMessage responseMessage = await lhmsStorage.updateLhms(
        lhms: checkInRecord.toLHMS(), );
    return responseMessage;
  }
}
//pagination query for check in requirements
class ListSelfCheckInByHotel{
  String hotelId;
  int limit = 20;
  ListSelfCheckInByHotel({required this.hotelId, this.limit = 20});

  int currentPage = -1;
  //late int pageSize;
  late PaginatedResult<LHMS> _result;
  //map<int,lhms>: pages: list<Lhms>
  final Map<int,List<LHMS?>> _resultPage = {};

  Future<ResponseMessage<List<LHMS?>?>> list() async{
    try {
      final currentRequest = ModelQueries.list<LHMS>(
        LHMS.classType,
        where: LHMS.QSK.eq(hotelId)
            .and(LHMS.QGSI1.eq("0")),
        limit: 20,);
      final firstResult = await Amplify.API
          .query(request: currentRequest)
          .response;
      if(firstResult.data == null){
        return ResponseMessage(
            status: 'fail',
            message: 'Error: ${firstResult.errors}', data: null);
      }
      _result = firstResult.data!;
      currentPage = 0;
      _resultPage.addAll({currentPage: _result.items});
      return ResponseMessage(
          status: 'success',
          message: 'Create new customer successfully.', data: _result.items);
    } on ApiException catch (e) {
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: null);
    }
  }
  Future<ResponseMessage<List<LHMS?>?>> next() async{
    if(currentPage < _resultPage.length){
      return ResponseMessage(
          status: 'fail',
          message: 'Error: no data',
          data: _resultPage[currentPage]);
    }
    if(_result.hasNextResult == true ) {
      try {
        final nextRequest = _result.requestForNextResult;
        final nextResult = await Amplify.API
            .query(request: nextRequest!)
            .response;
        if(nextResult.data == null) {
          return ResponseMessage(
              status: 'fail',
              message: 'Error: ${nextResult.errors}', data: null);
        }
        _result = nextResult.data!;
        _resultPage.addAll({++currentPage: _result.items});
        return ResponseMessage(
            status: 'success',
            message: 'Create new customer successfully.', data: _result.items);
      }on ApiException catch (e) {
        return ResponseMessage(
            status: 'fail', message: 'Error: ${e.message}', data: null);
      }
    }else{
      return ResponseMessage(
          status: 'fail', message: 'Error: no more data', data: null);
    }
}
  ResponseMessage<List<LHMS?>?> previous() {
    if(currentPage <= 0){
      return ResponseMessage(
          status: 'success',
          message: 'This is the first page.',
          data: _resultPage[currentPage]);
    }
    return ResponseMessage(
        status: 'success',
        message: '',
        data: _resultPage[--currentPage]);
  }
  Future<ResponseMessage<List<LHMS?>?>> refresh() async{
    return await list();
  }
}