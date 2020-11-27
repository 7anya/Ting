import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './CategoryCard.dart';
import './PopUpToCreateCard.dart';
import 'package:intl/intl.dart';

class DisplayCategory extends StatefulWidget {
  DisplayCategory({Key key}) : super(key: key);

  @override
  _DisplayCategoryState createState() => _DisplayCategoryState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DisplayCategoryState extends State<DisplayCategory> {
  List <Widget> ItemList= <Widget>[CategoryCard("plis end the semester"),CategoryCard("sleep")];
  int n=2;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  bool pickedDate = false;
  bool pickTime = false;
  bool valuefirst = false;
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CategoryName"),
        ),
        body: Center(
            child: Column(
              children: [Row(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.5,
                    child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search item',
                          labelText: 'Search item',
                        ),
                        onSaved: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (String value) {
                          return value.contains('@')
                              ? 'Do not use the @ char.'
                              : null;
                        }),),
                  RaisedButton(
                    child: Text("Search"),
                    onPressed:null,
                  )
                ],
              ),

              Text("saved items"),
              Row(
              children: <Widget>[
              SizedBox(width: 10,),
              CategoryCard("My cutie"),


              ]),
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add item here'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.add_outlined),
                              hintText: 'Add item',
                              labelText: 'Add item',
                            ),
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              return value.contains('@')
                                  ? 'Do not use the @ char.'
                                  : null;
                            }),
                          Row(

                            children: [
                              Container(
                                // margin: EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width /3,
                                decoration:
                                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                child: InkWell(
                                  onTap: () async {
                                    final DateTime picked = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1994),
                                      initialDate: date,
                                      lastDate: DateTime(2101),
                                      builder: (BuildContext context, Widget child) {
                                        return Theme(
                                          data: ThemeData.dark(),
                                          child: child,
                                        );
                                      },
                                    );
                                    if (picked != null && picked != date)
                                      setState(() {
                                        date = picked;
                                        pickedDate = true;
                                      });
                                  },
                                  child: Text(
                                    DateFormat('dd-MM-yyyy').format(date),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                // margin: EdgeInsets.all(20.0),
                                decoration:
                                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                child: InkWell(
                                  onTap: () async {
                                    final TimeOfDay picked = await showTimePicker(
                                      context: context,
                                      initialTime: time,
                                      builder: (BuildContext context, Widget child) {
                                        return Theme(
                                          data: ThemeData.dark(),
                                          child: child,
                                        );
                                      },
                                    );
                                    if (picked != null && picked != time)
                                      setState(() {
                                        time = picked;
                                        pickTime = true;
                                      });
                                  },
                                  child: Text(formatTimeOfDay(time),
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Add'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ),
          child: Icon(Icons.add_outlined),
          backgroundColor: Colors.green,
        ));
  }
}
