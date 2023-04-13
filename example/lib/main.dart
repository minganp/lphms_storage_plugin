import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lphms_auth_plugin/helpers/configure_amplify.dart';
import 'package:lphms_auth_plugin/helpers/futures.dart';
import 'package:lphms_auth_plugin/screens/entry.dart';
import 'package:lphms_storage_plugin_example/amplifyconfiguration.dart';
import 'package:lphms_storage_plugin_example/pages/home_page.dart';

bool isLoggedIn = false;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  configureAmplify(amplifyconfig);
  isLoggedIn = await checkExistingSession();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String loginSuccessRoute = '/homePage';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if(settings.name == loginSuccessRoute){
          return PageRouteBuilder(
              pageBuilder: (_,__,___) => const HomePage());
        }
        return MaterialPageRoute(builder: (_) =>
        isLoggedIn
            ? const HomePage()
            : EntryScreen(loginSuccessRoute: loginSuccessRoute,)
        );
      });
  }
}
