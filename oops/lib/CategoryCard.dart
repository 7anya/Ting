import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:oops/Globals.dart';

import 'package:share/share.dart';
import 'CalenderClient.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CategoryCard extends StatefulWidget {
  CategoryCard(this.categoryname, this.oldname, this.oldDescription,
      this.oldStart, this.oldEnd, this.oldQuantity);

  final String oldname, oldDescription, oldQuantity;
  final DateTime oldStart, oldEnd;
  final String categoryname;

  @override
  // _CategoryCardState createState() => _CategoryCardState();
  State<StatefulWidget> createState() {
    return _CategoryCardState();
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _CategoryCardState extends State<CategoryCard> {
  int n = 1;
  final _eventDescrption = TextEditingController();
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  TextEditingController _eventQuantity = TextEditingController();

  // String CardName=;
  bool valuefirst = false;
  final myController = TextEditingController();

  @override
  void initState() {
    _eventName.text = widget.oldname;
    _eventDescrption.text = widget.oldDescription;
    _eventQuantity.text = widget.oldQuantity;
    return super.initState();
  }

  // final  Mycontroller=new TextEditingController() ;
  void updateSize() {
    // CardNames.add(CategoryCard(_eventName.text));
    setState(() {
      n++;
    });
  }

  share(BuildContext context, String name, String description, String Quantity,
      DateTime start, DateTime end) {
    final RenderBox box = context.findRenderObject();

    Share.share(
        "Event name:${name} \n description: ${description}\n Quantity: ${Quantity} \n StartTIme:${start} \n EndTime:${end}",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        subject: "from Ting");
  }

  // _CategoryCardState(this.CardName);
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make an edit'),
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
                                    currentTime: widget.oldStart,
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
                                    currentTime: widget.oldEnd,
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
                            //log('add event pressed');
                            Globals.firestore
                                .collection("users")
                                .doc(Globals.auth.currentUser.uid)
                                .collection("categories")
                                .doc(widget.oldname)
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
                            calendarClient.insert(
                              _eventName.text,
                              startTime,
                              endTime,
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Globals.firestore
                    .collection("users")
                    .doc(Globals.auth.currentUser.uid)
                    .collection("categories")
                    .doc(widget.categoryname)
                    .update({
                  "events": FieldValue.arrayRemove([
                    {
                      "name": widget.oldname,
                      "description": widget.oldDescription,
                      "quantity": widget.oldQuantity,
                      "TimeOfStart": widget.oldStart,
                      "TimeOfEnd": widget.oldEnd,
                    }
                  ]),
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('share'),
              onPressed: () {
                share(context, _eventName.text, _eventDescrption.text,
                    _eventQuantity.text, startTime, endTime);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Edit'),
              onPressed: () {
                Globals.firestore
                    .collection("users")
                    .doc(Globals.auth.currentUser.uid)
                    .collection("categories")
                    .doc(widget.categoryname)
                    .update({
                  "events": FieldValue.arrayRemove([
                    {
                      "name": widget.oldname,
                      "description": widget.oldDescription,
                      "quantity": widget.oldQuantity,
                      "TimeOfStart": widget.oldStart,
                      "TimeOfEnd": widget.oldEnd,
                    }
                  ]),
                });
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
                  ]),
                });

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
    return Row(children: <Widget>[
      SizedBox(
        width: 10,
      ),
      Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: _showMyDialog,
          child: Container(
            width: 300,
            height: 100,
            child: Center(
              child: Text(widget.oldname,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
        ),
      ),
      Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: this.valuefirst,
        onChanged: (bool value) {
          setState(() {
            this.valuefirst = value;
          });
        },
      )
    ]);
  }
}
