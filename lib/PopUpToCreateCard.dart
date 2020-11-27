import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Popup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
        title: const Text('About Pop up'),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("hello"),
          ] ,
        ),
        actions: <Widget>[
    new FlatButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    textColor: Theme.of(context).primaryColor,
    child: const Text('Okay, got it!'),
    ),
    ],
    );
  }
}