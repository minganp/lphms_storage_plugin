//Class of hotel general info
import '../../utility/position_enum.dart';
import '../../utility/record_prefix.dart';
import '../LHMS.dart';
import 'hotel_change_log.dart';
import 'hotel_model.dart';
import 'hotel_staff.dart';

class HotelGeneralInfo {
  late HotelInfo hotelInfo;
  List<HotelName> hotelNames = [];
  List<HotelStaff> hotelStaffs = [];
  List<HotelChangeLogs> changeLogs = [];

  HotelGeneralInfo({required this.hotelInfo, required this.hotelNames, required this.hotelStaffs});

  HotelGeneralInfo.fromLHMS(List<LHMS?> info){
    for (var element in info) {
      if(element == null) {
        continue;
      } else if(element.SK.startsWith(rPref[RecType.hotelName]!)){
        hotelNames.add(HotelName.fromLHMS(element));
      }else if(element.SK.startsWith(rPref[RecType.hotelStaff]!)){
        hotelStaffs.add(HotelStaff.fromLHMS(element));
      }else if(element.SK.startsWith(rPref[RecType.hotel]!)){
        hotelInfo = HotelInfo.fromLHMS(element);
      }else if(element.SK.startsWith(rPref[RecType.changeLog]!)){
        changeLogs.add(HotelChangeLogs.fromLHMS(element));
      }
    }
  }
}