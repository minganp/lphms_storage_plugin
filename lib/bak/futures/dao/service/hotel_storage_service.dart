import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/models/hotel/hotel_model.dart';

import '../../../models/LHMS.dart';
import '../../../models/hotel/hotel_general_info.dart';

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
    QueryPredicate criteria = LHMS.pk.beginsWith("HO#$dis");
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
    QueryPredicateGroup criteria = LHMS.pk
        .beginsWith("HO#")
        .and(LHMS.sk.beginsWith('HN#').and(LHMS.sk.contains(name)));
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
  HotelGeneralInfo? hotelGeneralInfo;

  HotelQueryService();

  //get hotel info by hotel id
  Future<void> getHotelGeneralInfoById(String hotelId) async {
    QueryPredicate criteria = LHMS.pk.eq(hotelId);

    try {
      final request = ModelQueries.list(LHMS.classType, where: criteria);
      final response = await Amplify.API
          .query(
            request: request,
          )
          .response;
      final hotelInfo = response.data;
      hotelInfo == null
          ? hotelGeneralInfo = null
          : hotelGeneralInfo = HotelGeneralInfo.fromLHMS(hotelInfo.items);
    } on ApiException catch (e) {
      safePrint('Query failed $e');
      return;
    }
  }

  //get hotel info by hotel name
  Future<HotelInfo?> getHotelByName(String hotelName) async {
    QueryPredicate criteria = LHMS.pk
        .beginsWith("HO#")
        .and(LHMS.sk.beginsWith('HN#').and(LHMS.sk.eq(hotelName)));
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
}

class HotelStoreService {
  HotelStoreService();

  //for hotel registration, save hotel info and hotel name in laos  language as default.
  static Future<void> registerHotel(HotelInfo hotelInfo) async {
    await _saveHotelForReg(hotelInfo);
    await _saveHotelNameForReg(hotelInfo);
  }

  //for hotel update, save hotel info and hotel name in laos  language as default.
  static Future<void> updateHotel(HotelInfo hotelInfo) async {
    await _saveHotelForUpdate(hotelInfo);
    await _saveHotelNameForUpdate(hotelInfo);
  }

  static Future<void> _saveHotelForReg(HotelInfo hotelInfo) async {
    try {
      final request = ModelMutations.create(hotelInfo.toLHMS());
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      final created = response.data;
      if (created == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${hotelInfo.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }
  }

  static Future<void> _saveHotelNameForReg(HotelInfo hotelInfo) async {
    HotelName hotelName = HotelName.create(
        hotelId: hotelInfo.pk!, hotelName: hotelInfo.hna!, lang: "lo");
    try {
      final request = ModelMutations.create(hotelName.toLHMS());
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      final created = response.data;
      if (created == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${hotelName.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }
  }

  static Future _saveHotelForUpdate(HotelInfo hotelInfo) async {
    try {
      final request = ModelMutations.update(hotelInfo.toLHMS());
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      final updated = response.data;
      if (updated == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${hotelInfo.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }
  }

  static Future _saveHotelNameForUpdate(HotelInfo hotelInfo) async {
    HotelName hotelName = HotelName.create(
        hotelId: hotelInfo.pk!, hotelName: hotelInfo.hna!, lang: "lo");
    try {
      final request = ModelMutations.update(hotelName.toLHMS());
      final response = await Amplify.API
          .mutate(request: request)
          .response;
      final updated = response.data;
      if (updated == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${hotelName.toString()}');
    } on ApiException catch (e) {
      safePrint('Mutation failed $e');
    }
  }
}
