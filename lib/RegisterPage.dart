import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import './DropDown.dart';
class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Registration page "),
          ),
          body: Container(
              child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'What do people call you?',
                  labelText: 'Name *',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              MyDropDown(),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'Profession',
              //     labelText: 'Profession*',
              //   ),
              //   onSaved: (String value) {
              //     // This optional block of code can be used to run
              //     // code when the user saves the form.
              //   },
              //   validator: (String value) {
              //     return value.contains('@') ? 'Do not use the @ char.' : null;
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Email',
                  labelText: 'Email*',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Mobile Number',
                  labelText: 'Mobile Number *',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    child: Text("Register"),
                    onPressed: null,
                  )),
            ],
          ))),
    );
  }
}
