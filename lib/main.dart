import 'package:flutter/material.dart';

import 'package:ui_design/ui/Home.dart';
import 'package:ui_design/ui/attLog.dart';
import 'package:ui_design/ui/attSubmit.dart';
import 'package:ui_design/ui/login.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حضرني',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,

      ),
      routes: {
        '/': (context) => attSubmit(),
        // '/home': (context) => Home(),
        '/attLog': (context) => attLog(),
        '/attSubmit': (context) => attSubmit(),
      }
    );
  }
}
