import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oops/Globals.dart';

import './GenerateCard.dart';

class Dashboard extends StatefulWidget {
  List<Widget> CardNames= <Widget> [];
  String profession;

  Dashboard(this.profession) {
    if (profession == "Home-maker") {
      // this.CardNames = <Widget>[
      //   GenerateCard("Kitchen"),
      //   GenerateCard("Groceries"),
      //   GenerateCard("Maintenance"),
      //   GenerateCard("TO DO"),
      // ];
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Kitchen")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Groceries")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Maintenance")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("TO DO")
          .set({});
    } else if (profession == "Working professionals") {
      // this.CardNames = <Widget>[
      //   GenerateCard("Home"),
      //   GenerateCard("TO DO"),
      //   GenerateCard("Work"),
      //   GenerateCard("planned trips")
      // ];
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Home")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("TO DO")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Work")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("planned trips")
          .set({});
    } else if (profession == "Student") {
      // this.CardNames = <Widget>[
      //   GenerateCard("Homework"),
      //   GenerateCard("TO DO"),
      //   GenerateCard("Grades"),
      //   GenerateCard("planned trips")
      // ];
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Homework")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("TO DO")
          .set({});
      // Globals.firestore
      //     .collection("users")
      //     .doc(Globals.auth.currentUser.uid)
      //     .collection("categories")
      //     .doc("Grades")
      //     .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("planned trips")
          .set({});
    } else {
      // this.CardNames = <Widget>[
      //   GenerateCard("Homework"),
      //   GenerateCard("TO DO"),
      //   GenerateCard("Grades"),
      //   GenerateCard("planned trips")
      // ];
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Groceries")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("TO DO")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Home maintenance")
          .set({});
      Globals.firestore
          .collection("users")
          .doc(Globals.auth.currentUser.uid)
          .collection("categories")
          .doc("Planned trips")
          .set({});
    }
  }

  @override
  _DashboardState createState() => _DashboardState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DashboardState extends State<Dashboard> {
  int n = 0;
  final myController = TextEditingController();
  DateTime date = DateTime.now();
  Future<QuerySnapshot> categoriesFetched;

  Future<QuerySnapshot> fetchCategories() async {
    QuerySnapshot categories = await Globals.firestore
        .collection("users")
        .doc(Globals.auth.currentUser.uid)
        .collection("categories")
        .get();
    categories.docs.forEach((element) {
      widget.CardNames.add(GenerateCard(element.id));
      print(element.id);
    });
    setState(() {
      n = widget.CardNames.length;
    });
    return categories;
  }

  @override
  void initState() {
    super.initState();
    categoriesFetched = fetchCategories();
  }

  void updateSize() {
    widget.CardNames.add(GenerateCard(myController.text));
    Globals.firestore
        .collection("users")
        .doc(Globals.auth.currentUser.uid)
        .collection("categories")
        .doc(myController.text)
        .set({});
    setState(() {
      myController.text = null;
      n++;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create new category here'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Name?',
                    labelText: 'Name ',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Create'),
              onPressed: () {
                updateSize();
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
        future: categoriesFetched,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Color(0xfff7c4dff),
                  title: Row(
                    children: [
                      Text("Welcome to Dashboard "),
                    ],
                  )),
              body: Container(
                  // height: 300,
                  color: Color(0xfffede7f6),
                  child: Center(
                      child: Column(
                    children: [ Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: n,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 110,
                              // color: Colors.amber[colorCodes[index]],
                              child: Center(child: widget.CardNames[index]),
                            );
                          }) ,
                    )
                     ,
                    ],
                  ))),
              floatingActionButton: Container(
                height: 120,
                width: 60,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: _showMyDialog,
                      child: Icon(Icons.add_outlined),
                      backgroundColor: Color(0xffff40082),
                    ),
                    FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: () async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1994),
                          initialDate: date,
                          lastDate: DateTime(2101),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.light(),
                              child: child,
                            );
                          },
                        );
                      },
                      child: Icon(Icons.book_online),
                      backgroundColor: Color(0xfff7c4dff),
                    )
                  ],
                ),
              ));
        });
  }
}
