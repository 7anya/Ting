import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oops/Globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './DashBoard.dart';

import 'Login.dart';

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

  Future<void> initFirebaseFuture;
  @override
  void initState() {
    super.initState();
    initFirebaseFuture = init();
  }
  Future<void> init() async {
    await Firebase.initializeApp();
    Globals.auth= FirebaseAuth.instance;
    Globals.firestore= FirebaseFirestore.instance;
  }
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Home(),
    // );
    return new FutureBuilder(
      future: initFirebaseFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialApp(
        home: Globals.auth.currentUser == null? LoginPage() :Dashboard("Homemaker"),

        );
    }

    ,);
  }// =>
}
// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return DisplayCategory();
//   }
// }