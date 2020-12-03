import 'package:flutter/material.dart';
import 'package:oops/DashBoard.dart';
import 'package:oops/sign_in.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserNumber= TextEditingController();
  String dropdownValue = 'Profession';

  @override
  void initState() {
    super.initState();
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
        onPressed: UserNumber==null?null: () {
          signInWithGoogle(UserNumber.text,dropdownValue).then((result) {
            if (result != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Dashboard(dropdownValue);
                  },
                ),
              );
            }
          });
        },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              TextFormField(
                controller: UserNumber,
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
              items: <String>['Working professionals', 'Home-makers', 'Job-seekers ', 'Bachelors','Student','Profession']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ) ,
          ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }


}