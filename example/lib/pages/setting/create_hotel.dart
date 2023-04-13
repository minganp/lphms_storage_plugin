import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lphms_storage_plugin/models/hotel_model.dart';
import 'package:lphms_storage_plugin/widgets/prov_drop_down.dart';

class CreateHotel extends StatefulWidget {
  const CreateHotel({Key? key}) : super(key: key);
  static Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return const CreateHotel();
      },
    );
  }
  @override
  State createState() => _CreateHotelState();
}

class _CreateHotelState extends State<CreateHotel> {
  late HotelInfo hotelInfo;
  final TextEditingController _hotelNameCtl = TextEditingController();
  final TextEditingController _mobileCtl = TextEditingController();
  final TextEditingController _latitudeCtl = TextEditingController();
  final TextEditingController _longitudeCtl = TextEditingController();

  late String _hotelName;
  late double _latitude;
  late double _longitude;
  late String _mobile;
  String? _prov;
  String? _dis;

  onProvSelected(String prov) {
    setState(() {
      _prov = prov;
    });
  }

  onDisSelected(String district) {
    _dis = district;
  }

  _generateHotelForReg() {
    hotelInfo = HotelInfo.forReg(
        hotelName: _hotelName,
        province: _prov,
        district: _dis,
        mobile: _mobile,
        latitude: _latitude,
        longitude: _longitude);
    Navigator.of(context).pop(hotelInfo);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hotelNameCtl.addListener(() {
      _hotelName = _hotelNameCtl.value.text;
    });
    _mobileCtl.addListener(() {
      _mobile = _mobileCtl.value.text;
    });
    _latitudeCtl.addListener(() {
      _latitudeCtl.value.text != ""?(_latitude = double.parse(_latitudeCtl.value.text)):0;
    });
    _longitudeCtl.addListener(() {
      _longitudeCtl.value.text !=""?_longitude = double.parse(_longitudeCtl.value.text):0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Hotel"),
      ),
      body: Material(child:Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                labelText: "Hotel Name", border: OutlineInputBorder()),
            controller: _hotelNameCtl,
          ),
          Row(
            children: [
              provDropDown(onProvSelected),
              disDropDown(_prov, onDisSelected),
            ],
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: "Latitude", border: OutlineInputBorder()),
            controller: _latitudeCtl,
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: "Longitude", border: OutlineInputBorder()),
            controller: _longitudeCtl,
          ),
          TextField(
            decoration: const InputDecoration(
              label: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            controller: _mobileCtl,
          ),
          MaterialButton(
              onPressed: _generateHotelForReg, child: const Text("Submit"))
        ],
      ),
    ));
  }
}
