import 'package:flutter/material.dart';
import 'package:taxiapplication/widgets/buttonNU.dart';
import 'package:taxiapplication/widgets/label.dart';
import 'package:taxiapplication/widgets/newEmail.dart';
import 'package:taxiapplication/widgets/newName.dart';
import 'package:taxiapplication/widgets/registerbutton.dart';
import 'package:taxiapplication/widgets/signup.dart';
import 'package:taxiapplication/widgets/textNew.dart';
import 'package:taxiapplication/widgets/password.dart';
import 'package:taxiapplication/widgets/button.dart';

class SubmitPage extends StatefulWidget {
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage>{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 220, 82, 1)
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
                  NewName(),
                  NewEmail(),
                  ButtonNewUser()
                ],
              )
            ],
          ),
        ),
      );
  }
}