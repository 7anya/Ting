import 'dart:async';

import 'package:flutter/material.dart';
import './RegisterPage.dart';
import './DashBoard.dart';
import 'DisplayCategory.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    // home:DisplayCategory(),
    home:Dashboard(),
  );
}
// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return DisplayCategory();
//   }
// }