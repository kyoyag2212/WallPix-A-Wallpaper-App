import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WallPix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor:Colors.grey[800]
      ),
      home: Home(),
    );
  }
}

