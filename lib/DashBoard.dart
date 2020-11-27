import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './GenerateCard.dart';
import './PopUpToCreateCard.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DashboardState extends State<Dashboard> {
  List<Widget> CardNames = <Widget>[];
  int n = 0;
  final myController = TextEditingController();

  void updateSize() {
    CardNames.add(GenerateCard(myController.text));
    setState(() {
      myController.text=null;
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Dashboard "),
        ),
        body: Container(
            child: Center(
                child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: n,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    // color: Colors.amber[colorCodes[index]],
                    child: Center(child: CardNames[index]),
                  );
                }),
          ],
        ))),
        floatingActionButton: FloatingActionButton(
          onPressed: _showMyDialog,
          child: Icon(Icons.add_outlined),
          backgroundColor: Colors.green,
        ));
  }
}
