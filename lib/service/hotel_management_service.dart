import 'package:lphms_storage_plugin/dao/response_message.dart';

import '../dao/hotel_storage_dao.dart';

class HotelManageService{
  //1. set hotel sk to HA_ACTIVATED, the record which PK is hotelId and SK is HA_FALSE
  // 2. set hotel admin cac to adminAccount, the record which PK is hotelId and SK is HS_<staffId>
  static Future<ResponseMessage> activateHotel({
    required String hotelId,
    required String adminAccount,
    required String adminId}) async =>
    await HotelStoreService.activateHotel(
        toActivate: true, hotelId: hotelId, adminId: adminId, adminAcc: adminAccount);

  static Future<ResponseMessage> deActivateHotel({
    required String hotelId,
    required String adminAccount,
    required String adminId}) async =>
      await HotelStoreService.activateHotel(
          toActivate: false, hotelId: hotelId, adminId: adminId, adminAcc: adminAccount);

}