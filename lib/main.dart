import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/HomePage.dart';
import 'package:music_app/screens/PlayListPage.dart';
import 'package:music_app/screens/SongPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      
      home: HomePage(),
      getPages: [
        GetPage(name: '/', page:() => HomePage()),
        GetPage(name: '/song', page:() => SongPage()),
        GetPage(name: '/playlist', page:() => PlayListPage()),
        ],
    );
  }
}


