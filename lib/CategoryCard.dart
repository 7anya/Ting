import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CategoryCard extends StatefulWidget {
  CategoryCard(this.label);
  final String label;
  @override
  // _CategoryCardState createState() => _CategoryCardState();
  State<StatefulWidget> createState() {
    return _CategoryCardState();
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _CategoryCardState extends State<CategoryCard> {

  // String CardName=;
  bool valuefirst = false;
  final myController = TextEditingController();
  // final  Mycontroller=new TextEditingController() ;

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
                TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Make a edit',
                    labelText: 'Name ',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Edit'),
              onPressed: () {

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
    return Row(
        children: <Widget>[
          SizedBox(width: 10,),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: _showMyDialog,
              child: Container(
                width: 300,
                height: 100,
                child: Center(
                  child: Text(widget.label,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
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
        ]
    );
  }

}