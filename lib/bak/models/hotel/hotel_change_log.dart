//change log for hotel
import '../../utility/position_enum.dart';
import '../../utility/record_prefix.dart';
import '../LHMS.dart';

class HotelChangeLogs {
  String? pk; //hotelId
  String? sk; //change log id:  CL#<datetime>#<actions>
  String? clg; //change login string
  String? action;

  HotelChangeLogs({
    required this.pk,
    this.sk,
    this.clg,
  });

  HotelChangeLogs.create(
      {required String hotelId,
      required String changeLogId,
      required String changeLogStr}) {
    pk = hotelId;
    sk = "${rPref[RecType.changeLog]}#${DateTime.now()}#$action";
    clg = changeLogStr;
  }

  HotelChangeLogs.fromLHMS(LHMS lhms) {
    pk = lhms.PK;
    sk = lhms.SK;
    clg = lhms.clg;
  }

  LHMS toLHMS() {
    return LHMS(
      PK: pk!,
      SK: sk!,
      clg: clg,
    );
  }

  String toStr() {
    return "Change date: ${sk!.split('#')[1]}, Action: ${sk!.split('#')[2]}, Change log: $clg";
  }
}
