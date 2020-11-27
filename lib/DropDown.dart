import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  MyDropDown({Key key}) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyDropDownState extends State<MyDropDown> {
  String dropdownValue = 'Profession';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 2.0),
      width: MediaQuery.of(context).size.width,
      child:DropdownButton<String>(
        value: dropdownValue,
        // icon: Icon(Icons.person),
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>[' working professionals', ' home-makers', ' job-seekers ', ' bachelors','Student','Profession']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ) ,
    );
  }
}
