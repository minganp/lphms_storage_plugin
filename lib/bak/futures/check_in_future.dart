import 'package:lphms_storage_plugin/futures/dao/interface_storage.dart';
import 'package:lphms_storage_plugin/models/check_in/check_in_model.dart';

class CheckInOutFuture{
  ILhmsStorage storage;
  CheckInOutFuture(this.storage);
  
  Future checkIn(CheckInRecord checkInRecord) async{
    await storage.saveLhms(checkInRecord.toLHMS().copyWith(ihs: 1,));
  }

  Future checkOut(CheckInRecord checkInRecord) async{
    await storage.saveLhms(checkInRecord.toLHMS().copyWith(ihs: null));
  }
}