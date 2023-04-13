import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lphms_storage_plugin/lphms_storage_plugin.dart';
import 'package:lphms_storage_plugin/models/hotel_model.dart';
import 'package:lphms_storage_plugin_example/pages/setting/create_hotel.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String _platformVersion = 'Unknown';
  final _lphmsStoragePlugin = LphmsStoragePlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _lphmsStoragePlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  Future<void> _navigateToCreateHotelForReg(BuildContext newContext) async{
    HotelInfo result = await Navigator.push(
        newContext,
        MaterialPageRoute(builder: (context) => const CreateHotel())
    );
    if(!mounted) return;
    print("${result.pk},${result.sk},${result.gsi1},${result.lat}");
    ScaffoldMessenger.of(newContext)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text("${result.pk},${result.sk},${result.gsi1},${result.lat}")));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Column(
                children:[
                  Text('Running on: $_platformVersion\n'),
                  Builder(builder:(context){return MaterialButton(
                      onPressed: () async => await _navigateToCreateHotelForReg(context),
                      child: const Text("Create Hotel For Reg"));}),
                ]
            ),
          ),
        ));  }

}