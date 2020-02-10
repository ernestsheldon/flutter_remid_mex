
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remid_me/screens/HomePage.dart';


void main() async {
  ///
  /// Force the layout to Portrait mode
  ///
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,

  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterTodo',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

