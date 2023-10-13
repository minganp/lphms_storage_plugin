import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/dao/baseAmpApiDao.dart';
import 'package:lphms_storage_plugin/dao/scripts/graphql_scripts.dart';
import 'package:lphms_storage_plugin/dao/response_message.dart';
import 'package:lphms_storage_plugin/utility/record_prefix.dart';

import '../../models/LHMS.dart';
import '../models/hotel/hotel_general_info.dart';
import '../models/hotel/hotel_model.dart';
import '../models/hotel/hotel_staff.dart';
import 'lhms_base_dao.dart';

class HotelPaginateQueryService {
  PaginatedResult<LHMS>? paginatedHotelsList;

  HotelPaginateQueryService();

  //hotel list by page, the first page is 1.
  // key is page number, value is hotel list of that page
  Map<int, List<HotelInfo>> hotelPageList = {};

  //the maximum page number that already loaded
  int maxPage = 0;

  //list hotels by district
  Future<List<HotelInfo>> getHotelsByDis(
      {required String dis, int limit = 100}) async {
    print("getHotelsByDis: $dis");
    QueryPredicateGroup criteria =
        LHMS.QPK.beginsWith("HO#").and(LHMS.QSK.beginsWith("${rPref[RecType.hotelActivated]}#"));
    //QueryPredicate criteria = LHMS.QPK.beginsWith("HO#$dis");
    //reset hotelPageList and maxPage
    hotelPageList = {};
    maxPage = 0;
    try {
      final request = ModelQueries.list(
        LHMS.classType,
        where: criteria,
        limit: limit,
      );

      final result = await Amplify.API
          .query(
            request: request,
          )
          .response;
      paginatedHotelsList = result.data;
      if (paginatedHotelsList != null) {
        var hotels = <HotelInfo>[];
        maxPage++;
        for (var hotel in paginatedHotelsList!.items) {
          hotels.add(HotelInfo.fromLHMS(hotel!));
        }
        hotelPageList = {maxPage: hotels};
      } else {
        return [];
      }
      return hotelPageList[maxPage]!;
    } on ApiException catch (e) {
      safePrint('Query failed $e');
      return [];
    }
  }

  //list hotels by name
  Future<List<HotelInfo>> getHotelsByName(
      {required String name, int limit = 100}) async {
    QueryPredicateGroup criteria = LHMS.QPK
        .beginsWith("HO#")
        .and(LHMS.QSK.beginsWith('HN#').and(LHMS.QPK.contains(name)));
    //reset hotelPageList and maxPage
    hotelPageList = {};
    maxPage = 0;
    try {
      final request = ModelQueries.list(
        LHMS.classType,
        where: criteria,
        limit: limit,
      );

      final paginatedHotelsList = await Amplify.API
          .query(
            request: request,
          )
          .response;
      var hotels = <HotelInfo>[];
      for (var hotel in paginatedHotelsList.data!.items) {
        hotels.add(HotelInfo.fromLHMS(hotel!));
        maxPage++;
      }
      hotelPageList = {maxPage: hotels};
      return hotels;
    } on ApiException catch (e) {
      safePrint('Query failed $e');
      return [];
    }
  }

  bool get hasNextPage => paginatedHotelsList?.hasNextResult ?? false;

  //Because of the limitation of amplify, we can only get next page of data by using the requestForNextResult
  //So we need to save the requestForNextResult and use it to get next page of data.
  Future<List<HotelInfo>> getHotelsOfCertainPage(int pIndex) async {
    if (pIndex < maxPage) {
      return hotelPageList[pIndex] ?? [];
    }
    if (hasNextPage) {
      try {
        final request = paginatedHotelsList!.requestForNextResult;
        final response = await Amplify.API
            .query(
              request: request!,
            )
            .response;
        paginatedHotelsList = response.data;
        if (paginatedHotelsList != null) {
          var hotels = <HotelInfo>[];
          for (var hotel in paginatedHotelsList!.items) {
            hotels.add(HotelInfo.fromLHMS(hotel!));
          }
          maxPage++;
          hotelPageList[maxPage] = hotels;
        }

        return hotelPageList[maxPage] ?? [];
      } on ApiException catch (e) {
        safePrint('Query failed $e');
        return [];
      }
    }
    return [];
  }
}

class HotelQueryService {
  //fetch hotel info as HotelGeneralInfo
  //HotelGeneralInfo? hotelGeneralInfo;

  //get hotel info by hotel id
  static Future<HotelGeneralInfo?> getHotelGeneralInfoById(
      String hotelId) async {
    print("getHotelGeneralInfoById: $hotelId");
    //QueryPredicate criteria = LHMS.QPK.eq(hotelId);
    HotelGeneralInfo? hotelGeneralInfo;

    try {
      final operation = Amplify.API
          .query(
              request: GraphQLRequest(
                  document: sQueryLHMSByPK, variables: {'pk': hotelId}))
          .response;
      final result = await operation;
      if (result.data == null) {
        print("result is null");
        return null;
      }
      print(result.data);
      final json = jsonDecode(result.data!);
      if (json["queryLHMSByPK"]["items"].length < 1) return null;
      hotelGeneralInfo =
          HotelGeneralInfo.fromLHMS(json["queryLHMSByPK"]["items"]);
    } on ApiException catch (e) {
      safePrint('Query failed $e');
      return null;
    }
    return hotelGeneralInfo;
  }
  //for customer check in, get hotel info by hotel id
  //sk is "HA#TRUE" or "HA#FALSE", that means hotel activate status
  static Future<ResponseMessage> getHotelInfoById(
      String hotelId,String sk) async {
    //LHMS lhms;
    ResponseMessage responseMessage =
      await BaseAmpApiDao().queryLhms(script: getHotelInfo, args: {'PK':hotelId,'SK':sk});

    /*
    final request = ModelQueries.get(
        LHMS.classType,
        LHMSModelIdentifier(keys:{'PK': hotelId, 'SK': sk}));
    try{
      final response = await Amplify.API.query(request: request).response;
      final data = response.data;
      if(data == null){
        return ResponseMessage(
            status: 'fail',
            message: 'Error: ${response.errors}', data: response.errors);
      }else{
        print("getHotelInfoById: $data");
        lhms = data;
        return ResponseMessage(
            status: 'success',
            message: 'Create new customer successfully', data: lhms);
      }
    }on ApiException catch(e){
      return ResponseMessage(
          status: 'fail', message: 'Error: ${e.message}', data: e.toString());
    }
     */
    return responseMessage;
  }

  //get hotel info by hotel name
  static Future<HotelInfo?> getHotelByName(String hotelName) async {
    QueryPredicate criteria = LHMS.QPK
        .beginsWith("HO#")
        .and(LHMS.QSK.beginsWith('HN#').and(LHMS.QSK.eq(hotelName)));
    try {
      final request = ModelQueries.list(
        LHMS.classType,
        where: criteria,
        limit: 1,
      );
      final response = await Amplify.API
          .query(
            request: request,
          )
          .response;
      final hotel = response.data;
      if (hotel == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }
      return HotelInfo.fromLHMS(hotel.items[0]!);
    } on ApiException catch (e) {
      safePrint('Query failed $e');
      return null;
    }
  }

  //get hotelId with register uuid(sk) and secret key(gsi1)
  static Future<String?> getHotelIdBySecretKey(
      String regCode, String secretKey) async {
    print(
        "regcode: ${rPref[RecType.register]}#$regCode, secretKey: $secretKey");
    regCode = "${rPref[RecType.register]}#$regCode";
    /*
    const getHotelIdBySecretKey = r'''
      query GetHotelIdBySecretKey($regCode: String!, $secretKey: String!) {
        lHMSByGSI1(SK: $regCode, GSI1: $secretKey, limit: 1) {
          items {
            PK
            SK
            GSI1
          }
        }
      }
    ''';
     */
    try {
      final operation = Amplify.API
          .query(
            request: GraphQLRequest<String>(
              document: sQueryHotelIdBySecretKey,
              variables: {
                'regCode': regCode,
                'secretKey': secretKey,
              },
            ),
          )
          .response;
      /*
    QueryPredicateGroup criteria =
      LHMS.QSK.eq("${rPref[RecType.register]}#$regCode").and(
        LHMS.QGSI1.eq(secretKey));

    try {

      final request = ModelQueries.list(
        LHMS.classType,
        where: criteria,
        limit: 1,
      );


      final response = await Amplify.API
          .query(
            request: request,
          )
          .response;
      final hotel = response.data;

     */
      final hotel = await operation;
      print(hotel.errors.toString());
      print("hotel: ${hotel.data}");

      if (hotel.data == null) return null;
      Map<String, dynamic> hotelMap = jsonDecode(hotel.data!);
      //if(hotel == null) return null;
      //if (hotel.items.isEmpty) return null;
      //return hotel.items[0]!.id;
      if(hotelMap['lHMSByGSI1']['items'].length ==0) return null;
      print("hotelId:${hotelMap['lHMSByGSI1']['items'][0]['PK']}");
      return hotelMap['lHMSByGSI1']['items'][0]['PK'];
    } on ApiException catch (e) {
      safePrint('Query failed $e');
      return null;
    }
  }

  //get hotel info by register uuid(sk) and secret key(gsi1)
  static Future<HotelGeneralInfo?> getHotelGenInfoBySecretKey(
      String regCode, String secretKey) async {
    HotelGeneralInfo? hotelGeneralInfo;
    await getHotelIdBySecretKey(regCode, secretKey).then((value) async =>
        value == null
            ? hotelGeneralInfo = null
            : hotelGeneralInfo = await getHotelGeneralInfoById(value));
    return hotelGeneralInfo;
  }
}

class HotelStoreService {
  HotelStoreService();

  //each new hotel registration will create 4 records in the database
  //1. hotel info
  //2. hotel name
  //3. hotel activate(activate status: false  by default)
  //4. hotel staff
  static Future<void> registerHotelGen(
      HotelGeneralInfo hotelGeneralInfo) async {
    //write hotel information
    await LhmsBaseDao.writeNewRecLHMS(hotelGeneralInfo.hotelInfo.toLHMS());

    //write hotel Reg secret key(sk: uuid, gsi1: password)
    await LhmsBaseDao.writeNewRecLHMS(hotelGeneralInfo.hotelRegInfo!.toLHMS());

    //write hotel name record
    await _saveHotelNameForReg(hotelGeneralInfo.hotelInfo);

    //await _saveHotelActivateForReg(hotelGeneralInfo.hotelActivated!);
    //write hotel staff record
    await LhmsBaseDao.writeNewRecLHMS(hotelGeneralInfo.hotelStaffs[0].toLHMS());
  }

  //for hotel update, save hotel info and hotel name in laos  language as default.
  static Future<void> updateHotel(HotelInfo hotelInfo) async {
    await _saveHotelForUpdate(hotelInfo);
    await _saveHotelNameForUpdate(hotelInfo);
  }

  static Future<void> _saveHotelNameForReg(HotelInfo hotelInfo) async {
    HotelName hotelName = HotelName.create(
        hotelId: hotelInfo.pk!, hotelName: hotelInfo.hna!, lang: "lo");
    await LhmsBaseDao.writeNewRecLHMS(hotelName.toLHMS());
  }

  @Deprecated('Use HotelRegInfo instead')
  static Future<void> saveHotelActivateForReg(
      HotelActivated hotelActivated) async {
    try {
      final request = ModelMutations.create(hotelActivated.toLHMS());
      final response = await Amplify.API.mutate(request: request).response;
      final created = response.data;
      if (created == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${hotelActivated.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }
  }

  static Future<void> saveHotelStaff(HotelStaff hotelStaff) async =>
      await LhmsBaseDao.writeNewRecLHMS(hotelStaff.toLHMS());

  static Future _saveHotelForUpdate(HotelInfo hotelInfo) async =>
      await LhmsBaseDao.writeNewRecLHMS(hotelInfo.toLHMS());

  static Future _saveHotelNameForUpdate(HotelInfo hotelInfo) async {
    HotelName hotelName = HotelName.create(
        hotelId: hotelInfo.pk!, hotelName: hotelInfo.hna!, lang: "lo");
    LhmsBaseDao.writeNewRecLHMS(hotelName.toLHMS());
  }

  //activate or deactivate hotel
  static Future<ResponseMessage> activateHotel(
      {required bool toActivate,
      required String hotelId,
      required String adminId,
      required String adminAcc}) async {
    late GraphQLResponse<dynamic> response;
    print("$toActivate, $hotelId, $adminId, $adminAcc");

    try {
      final operation = Amplify.API
          .mutate(
              request: GraphQLRequest(
                  document: sActivateHotel,
                  variables: {
                    'aOrd': toActivate,
                    'cognitoAcc': adminAcc,
                    'hotelID': hotelId,
                    'staffId': adminId,
          }))
          .response;
      response = await operation;
      print(response.data);
      if(response.data == null){
        return ResponseMessage(
            status: 'fail',
            message: 'Hotel information not match. maybe caused by network connection. please try again. If the problem still persist, please contact Police admin.',
            data: null);
      }
      final resultJson = jsonDecode(response.data);
      final result =
          resultJson['activateHotel']['keys'] as List;
      if (result.isEmpty) {
        return ResponseMessage(
            status: 'success',
            message: 'activate or deactivate hotel failed',
            data: null);
      } else {
        return ResponseMessage(
            status: 'success',
            message: 'activate or deactivate hotel success',
            data: result);
      }
    } on ApiException catch (e) {
      return ResponseMessage(
          status: 'fail',
          message: 'activate or deactivate hotel failed',
          data: e.toString());
    }
  }
}
