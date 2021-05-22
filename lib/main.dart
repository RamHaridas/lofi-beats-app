import 'package:browser786/screens/homeMain.dart';
import 'package:browser786/screens/imageDetails.dart';
import 'package:browser786/screens/lofiPlayer.dart';
import 'package:browser786/screens/musicplayer.dart';
import 'package:browser786/screens/splash.dart';
import 'package:browser786/screens/topImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'San',
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => DrawerScale(),
        '/music': (context) => MusicPlayer(),
        '/details': (context) => DetailsPage(),
        '/lofi': (context) => LofiPlayer(),
        '/top': (context) => TopImageDetail(),
      },
      builder: EasyLoading.init(),
    );
  }
}
