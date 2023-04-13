import 'dart:math';

//import 'package:lphms_storage_plugin/utility/position_enum.dart';
//import 'package:lphms_storage_plugin/utility/record_prefix.dart';

//this uuid for hotel registration
String generateUuid(){
  String uuid = _compressTimestamp(DateTime.now())
      + _generateBase62Uuid(6);
  return uuid;
}
//for register hotel
String generatePassword(){
  String pass = _generateBase62Uuid(4);
  return pass;
}

String generateStaffId() => _generateBase62Uuid(4);
String generateHotelId() => _generateBase62Uuid(4);

String _generateBase62Uuid(int len) {
    final _random = Random.secure();
    const _chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final uuid = List.generate(len, (_) => _chars[_random.nextInt(_chars.length)]).join();
    return uuid;
  }

String _compressTimestamp(DateTime dateTime) {
  int timestamp = _dateTimeToUnixTimestamp(dateTime);
  final int offset = timestamp ~/ (24 * 3600);
  final int compressed = (offset + 63) % 128;
  return compressed.toRadixString(16).padLeft(2, '0');
}

int _dateTimeToUnixTimestamp(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch ~/ 1000;
}