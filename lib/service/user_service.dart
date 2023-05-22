import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:lphms_storage_plugin/dao/lhms_base_dao.dart';

import '../dao/response_message.dart';
import '../utility/position_enum.dart';
import '../dao/hotel_storage_dao.dart';
import '../models/hotel/hotel_general_info.dart';
import '../models/hotel/hotel_staff.dart';

class UserService {
  static Future<AuthUser?> getCognitoUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      return user;
    } on AuthException catch (e) {
      print(e);
    }
    return null;
  }
  static Future<List<HotelStaff>?> getHotelStaff(String? hotelId) async {
    HotelGeneralInfo? hotelGenInfo;
    hotelGenInfo = await HotelQueryService.getHotelGeneralInfoById(hotelId!);
    if (hotelGenInfo == null) {
      return null;
    }
    return hotelGenInfo.hotelStaffs;
  }
  static Future<ResponseMessage> createHotelStaff(HotelStaff hotelStaff) async {
    var rm = await LhmsBaseDao.writeNewRecLHMS(hotelStaff.toLHMS());
    rm.isSuccess
        ? rm.data = HotelStaff.fromLHMS(rm.data)
        : rm.data = null;
    return rm;
  }

  static HotelStaff? getCurrentHotelStaff(List<HotelStaff> hotelStaffList, AuthUser authUser)  =>
    hotelStaffList.firstWhere((element) => element.cac == authUser.userId);

  //cac is the user id of cognito user
  static HotelStaff? getStaffByCac(List<HotelStaff> hotelStaffList, String cac)  {
    return hotelStaffList
        .firstWhere((element) => element.cac == cac);
  }

  static HotelStaff? getAdminStaffByHotelId(List<HotelStaff> hotelStaffList) =>
      hotelStaffList.firstWhere((element) => element.hsp == Role.hotelAdmin);

  static bool isHotelAdminAccSet(List<HotelStaff> staff) {
    for (var element in staff) {
      if (element.hsp == Role.hotelAdmin) {
        if (element.cac != null) {
          return true;
        } else {
          return false;
        }
      }
    }
    throw Exception("Not found admin account. Please Contact System Admin.");
  }
}
