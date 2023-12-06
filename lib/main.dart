import 'package:flutter/material.dart';
import 'package:healthtic/sliderpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(52, 53, 65, 1),
      ),
      home: SliderPage(),
    );
  }
}
