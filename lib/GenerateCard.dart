import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenerateCard extends StatelessWidget {
String CardName;
GenerateCard(this.CardName);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          width: 300,
          height: 100,
          child: Center(
            child: Text('$CardName',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ),
      ),
    ) ;
  }
}

