import 'package:flutter/material.dart';
import 'package:taxiapplication/widgets/login_button.dart';
import 'package:taxiapplication/widgets/signup.dart';
import 'package:taxiapplication/widgets/textNew.dart';
import 'package:taxiapplication/widgets/newName.dart';
import 'package:taxiapplication/widgets/newEmail.dart';
import 'package:taxiapplication/widgets/buttonNU.dart';


class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.yellow, Colors.yellowAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SingUp(),
                    TextNew(),
                  ],
                ),
                ButtonNewUser(),
                ScndTime()
              ],
            ),
          ],
        ),
      ),
    );
  }
}