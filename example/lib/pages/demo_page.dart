import 'package:flutter/cupertino.dart';
import 'package:lphms_storage_plugin_example/amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
class AmplifyDemoApp extends StatefulWidget{
  const AmplifyDemoApp({Key? key}) : super(key: key);

  @override
  State createState() => _AmplifyDemoState();
}


class _AmplifyDemoState extends State<AmplifyDemoApp> {
  @override
  void initState(){
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async{
    Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));
    try{
      await Amplify.configure(amplifyconfig);
    }on AmplifyAlreadyConfiguredException{
      print("Tried to reconfigure amplify; this can occur when your app restarts on Android.");
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}