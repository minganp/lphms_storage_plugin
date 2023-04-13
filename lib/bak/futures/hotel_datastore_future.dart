import 'package:lphms_storage_plugin/function/uuid_generator.dart';
import 'package:lphms_storage_plugin/models/ModelProvider.dart';
import 'package:lphms_storage_plugin/models/LHMS.dart';
import 'package:lphms_storage_plugin/models/hotel/hotel_model.dart';
import 'package:lphms_storage_plugin/models/hotel/hotel_staff.dart';

import '../models/changeLog.dart';
import '../utility/position_enum.dart';
import 'dao/interface_storage.dart';

class HotelStorage {

  ILhmsStorage storage;

  HotelStorage(this.storage);

// to register a hotel , from hotel agency or police
  //hotelForReg has the same class of HotelInfo, but it's pk is uuid,
  //and hotel id stored in gsi1
  Future createHotelForReg({required HotelInfo hotelForReg,
  }) async =>
      await storage.saveLhms(hotelForReg.toLHMS());

  /*
    await storage.saveLhms(
        ChangeLog(pk: hotelInfo.pk!,logTag: "CreateForReg",logMsg: lhms.toJson()).toLHMS());
    */


  Future<LHMS> getHotelForReg({required String pk, //short UUID
    required String sk, //password
  }) async {
    LHMS? createdHotel = await storage.queryLhms(pk: pk, sk: sk);
    HotelInfo hotel;
    if (createdHotel == null) {throw Exception(
        "Bad register Number or Password");}
    if (createdHotel.GSI1 == null) {
      throw Exception("Bad register Number or Password");
    } else {
      hotel = HotelInfo.createFromReg(createdHotel);
    }
    return hotel.toLHMS();
  }

  Future newRegisterHotel({
    required LHMS hotel,
    required String sna,
    String? gna,
    String? mph,
    required String cac, //account of cognito
  }) async {
    //1. create hotel record
    //2. created admin staff
    //3. set hotel avl to -1
    hotel.copyWith(avl: -1);
    String staffId = generateStaffId();
    HotelStaff hotelStaff = HotelStaff(
      pk: hotel.PK,
      sk: staffId,
      sna: sna,
      gna: gna,
      mph: mph,
      cac: Role.HOTEL_ADMIN.toString(),
      avl: null,
    );
    await storage.saveLhms(hotel);
    await addHotelStaff(hotelStaff: hotelStaff);
    await storage.saveLhms(
        ChangeLog(pk: hotel.PK,
            logTag: "CreateHotelFromReg",
            logMsg: "Hotel Registered").toLHMS());
  }

  Future activateHotel({required String pk, /*hotel Id*/
  }) async {
    LHMS lhms = await storage.queryLhms(pk: pk, sk: pk);
    await storage.saveLhms(lhms.copyWith(avl: null));
    await storage.saveLhms(
        ChangeLog(pk: pk, logTag: "ActivateHotel", logMsg: "ActivateHotel")
            .toLHMS());
  }

  Future deactivateHotel({required String pk,}) async {
    LHMS lhms = await storage.queryLhms(pk: pk, sk: pk);
    await storage.saveLhms(lhms.copyWith(avl: -1));
    await storage.saveLhms(
        ChangeLog(pk: pk, logTag: "DeactivateHotel", logMsg: "DeactivateHotel")
            .toLHMS());
  }

  Future updateHotel({
    required String pk, //hotel Id
    required String sk, //hotel Id
    Set<String>? iUr,
    int? nor, //number of rooms
    double? lat, //latitude
    double? lon, //longitude
    String? addr, //address
  }) async {
    LHMS lhms = await storage.queryLhms(pk: pk, sk: sk);
    await storage.saveLhms(lhms.copyWith(
      iUr: iUr,
      nor: nor,
      lat: lat,
      lon: lon,
      addr: addr,
    ));
    String jsonStr = '"iUr": $iUr,"nor":$nor, "lat":$lat, "lon":$lon, "addr":$addr';
    await storage.saveLhms(
        ChangeLog(pk: pk, logTag: "UpdateHotel", logMsg: jsonStr).toLHMS()
    );
  }

  Future addHotelName({
    required HotelName hotelName
  }) async {
    await storage.saveLhms(hotelName.toLHMS());
    String jsonStr = '"name":${hotelName.sk}';
    await storage.saveLhms(
        ChangeLog(pk: hotelName.pk, logTag: "Add Hotel Name", logMsg: jsonStr)
            .toLHMS());
  }

  Future updateHotelName(String oldName, HotelName newName) async {
    LHMS hotelName = await storage.queryLhms(pk: newName.pk, sk: oldName);

    await storage.saveLhms(hotelName.copyWith(SK: newName.sk));

    String jsonStr = '"Hotel name changed from $oldName to ${newName.sk}"';
    await storage.saveLhms(
        ChangeLog(pk: newName.pk, logTag: "ChangeHotelName", logMsg: jsonStr)
            .toLHMS());
  }

  Future addHotelStaff({
    required HotelStaff hotelStaff //cognito account ID
  }) async {
    await storage.saveLhms(hotelStaff.toLHMS());
    await storage.saveLhms(
        ChangeLog(pk: hotelStaff.pk!,
            logTag: "AddHotelStaff",
            logMsg: hotelStaff.toStr()).toLHMS()
    );
  }

  Future activateHotelStaff({
    required HotelStaff staff,
  }) async {
    LHMS hotelStaff = await storage.queryLhms(pk: staff.pk!, sk: staff.sk!);
    hotelStaff.copyWith(avl: null);
    await storage.saveLhms(hotelStaff);
    await storage.saveLhms(
        ChangeLog(pk: staff.pk!,
            logTag: "ActivateHotelStaff",
            logMsg: "Activate ${staff.sk},Surname: ${staff
                .sna}, given name: ${staff.gna}").toLHMS()
    );
  }

  Future deactivateStaff({
    required HotelStaff staff,
  }) async {
    LHMS hotelStaff = await storage.queryLhms(pk: staff.pk!, sk: staff.sk!);
    hotelStaff.copyWith(avl: -1);
    await storage.saveLhms(hotelStaff);
    await storage.saveLhms(
        ChangeLog(pk: hotelStaff.PK,
            logTag: "DeactivateHotelStaff",
            logMsg: "Deactivate ${staff.sk},Surname: ${staff
                .sna}, given name: ${staff.gna}").toLHMS()
    );
  }

}