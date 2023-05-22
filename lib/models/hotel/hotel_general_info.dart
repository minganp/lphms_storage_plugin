//Class of hotel general info
import '../../../models/LHMS.dart';
import '../../utility/position_enum.dart';
import '../../utility/record_prefix.dart';
import 'hotel_change_log.dart';
import 'hotel_model.dart';
import 'hotel_staff.dart';

class HotelGeneralInfo {
  HotelInfo hotelInfo;
  HotelActivated? hotelActivated;
  List<HotelName> hotelNames = [];
  List<HotelStaff> hotelStaffs = [];
  List<HotelChangeLogs> changeLogs = [];

  HotelGeneralInfo({
    required this.hotelInfo,
    this.hotelNames = const [],
    this.hotelStaffs = const [],
    this.hotelActivated,
  });

  factory HotelGeneralInfo.fromLHMS(List<dynamic> info){
    List<HotelName> hotelNames = [];
    List<HotelStaff> hotelStaffs = [];
    List<HotelChangeLogs> changeLogs = [];
    late HotelInfo hotelInfo ;
    HotelActivated? hotelActivated;
    for (var element in info) {
      if(element == null) continue;
      var lhms = LHMS.fromJson(element);
      if(lhms.SK.startsWith(rPref[RecType.hotelName]!)){
        hotelNames.add(HotelName.fromLHMS(lhms));
      }else if(lhms.SK.startsWith(rPref[RecType.hotelStaff]!)){
        hotelStaffs.add(HotelStaff.fromLHMS(lhms));
      }else if(lhms.SK.startsWith(rPref[RecType.register]!)){
        hotelInfo = HotelInfo.fromLHMS(lhms);
      }else if(lhms.SK.startsWith(rPref[RecType.changeLog]!)){
        changeLogs.add(HotelChangeLogs.fromLHMS(lhms));
      }else if(lhms.SK.startsWith(rPref[RecType.hotelActivated]!)){
        hotelActivated = HotelActivated.fromLHMS(lhms);
      }
    }
    return HotelGeneralInfo(
      hotelInfo: hotelInfo,
      hotelNames: hotelNames,
      hotelStaffs: hotelStaffs,
      hotelActivated: hotelActivated,
    );
}
}