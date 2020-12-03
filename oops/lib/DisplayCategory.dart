import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:oops/Globals.dart';
import './CategoryCard.dart';

import 'package:intl/intl.dart';
import 'Searchbar.dart';

import 'CalenderClient.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DisplayCategory extends StatefulWidget {
  String categoryname;

  DisplayCategory(this.categoryname);

  @override
  _DisplayCategoryState createState() => _DisplayCategoryState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DisplayCategoryState extends State<DisplayCategory> {
  List<Widget> CardNames = <Widget>[];
  int n = 0;
  final _eventDescrption = TextEditingController();
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  TextEditingController _eventQuantity = TextEditingController();
  Future<DocumentSnapshot> categoryDocument;

  Future<DocumentSnapshot> fetchCategory() async {
    DocumentSnapshot category = await Globals.firestore
        .collection("users")
        .doc(Globals.auth.currentUser.uid)
        .collection("categories")
        .doc(widget.categoryname)
        .get();
    print("Category Data of " + widget.categoryname);
    print(category.data());
    List<dynamic> events = category.get("events");
    print(events);
    events.forEach((event) {
      String name = event["name"];
      String description= event["description"];
      DateTime start =event["TimeOfEnd"];
      DateTime end =event["TimeOfStart"];
      String quantity=event["quantity"];
      CardNames.add(CategoryCard(widget.categoryname,name,description,start,end,quantity));
      print(name);
    });
    setState(() {
      n = CardNames.length;
    });
    return category;
  }

  @override
  void initState() {
    super.initState();
    categoryDocument = fetchCategory();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  void updateSize() {
    CardNames.add(CategoryCard(widget.categoryname,_eventName.text,_eventDescrption.text,this.startTime,this.endTime,_eventQuantity.text));
    setState(() {
      n++;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create new item here'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2019, 3, 5),
                                    maxTime: DateTime(2200, 6, 7),
                                    onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  setState(() {
                                    this.startTime = date;
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Text(
                                'Event Start Time',
                                style: TextStyle(color: Colors.blue),
                              )),
                          Text('$startTime'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2019, 3, 5),
                                    maxTime: DateTime(2200, 6, 7),
                                    onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  setState(() {
                                    this.endTime = date;
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Text(
                                'Event End Time',
                                style: TextStyle(color: Colors.blue),
                              )),
                          Text('$endTime'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _eventName,
                          decoration:
                              InputDecoration(hintText: 'Enter Event name'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _eventDescrption,
                          decoration:
                              InputDecoration(hintText: 'Enter Description'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _eventQuantity,
                          decoration:
                              InputDecoration(hintText: 'Enter Quantity'),
                        ),
                      ),
                      RaisedButton(
                          child: Text(
                            'Tap to insert Event in Calender',
                          ),
                          color: Colors.grey,
                          onPressed: () {
                            // //log('add event pressed');
                            // Globals.firestore
                            //     .collection("users")
                            //     .doc(Globals.auth.currentUser.uid)
                            //     .collection("categories")
                            //     .doc(widget.categoryname)
                            //     .update({
                            //   "events": FieldValue.arrayUnion([
                            //     {
                            //       "name": _eventName.text,
                            //       "description": _eventDescrption.text,
                            //       "quantity": _eventQuantity.text,
                            //       "TimeOfStart": startTime,
                            //       "TimeOfEnd": endTime,
                            //     }
                            //   ])
                            // });
                            calendarClient.insert(
                              _eventName.text,
                              startTime,
                              endTime,
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Create'),
              onPressed: () {

                Globals.firestore
                    .collection("users")
                    .doc(Globals.auth.currentUser.uid)
                    .collection("categories")
                    .doc(widget.categoryname)
                    .update({
                  "events": FieldValue.arrayUnion([
                    {
                      "name": _eventName.text,
                      "description": _eventDescrption.text,
                      "quantity": _eventQuantity.text,
                      "TimeOfStart": startTime,
                      "TimeOfEnd": endTime,
                    }
                  ])
                });
                updateSize();
                //TODO calender imput
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: categoryDocument,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> document) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xffff40082),
                title: Text(widget.categoryname),
              ),
              body: Container(
                  color: Color(0xfffffebee),
                  child: Center(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Search(),
                        ],
                      ),
                      Text("Your saved items"),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: n,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 100,
                                // color: Colors.amber[colorCodes[index]],
                                child: Center(child: CardNames[index]),
                              );
                            })
                      )
                     ,
                    ],
                  ))),
              floatingActionButton: FloatingActionButton(
                onPressed: _showMyDialog,
                child: Icon(Icons.add_outlined),
                backgroundColor: Color(0xffff40082),
              ));
        });
  }
}
