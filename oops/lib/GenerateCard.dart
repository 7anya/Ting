import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oops/DisplayCategory.dart';

class GenerateCard extends StatelessWidget {
  String CardName;

  GenerateCard(this.CardName);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child:Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DisplayCategory(CardName);
                },
              ),
            );
          },
          child: Container(
            width: 300,
            height: 600,
            child: Center(
              child: Text('$CardName',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
        ),
      ) ,
    ) ;
  }
}
