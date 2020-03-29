import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapplication/widgets/label.dart';
import 'package:taxiapplication/widgets/login_button.dart';
import 'package:taxiapplication/widgets/signup.dart';
import 'package:taxiapplication/widgets/textHint.dart';
import 'package:taxiapplication/widgets/textNew.dart';
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
          color: Color.fromRGBO(255, 220, 82, 1),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Label()
                  ],
                ),
                Row(
                  children: <Widget>[
                    TextNew(),
                  ],
                ),
                Row(
                  children: <Widget>[
                    TextHint()
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