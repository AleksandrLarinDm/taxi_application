import 'package:flutter/material.dart';
import 'package:taxiapplication/widgets/label.dart';
import 'package:taxiapplication/widgets/login_confirmation.dart';
import 'package:taxiapplication/widgets/password.dart';
import 'package:taxiapplication/widgets/signin.dart';
import 'package:taxiapplication/widgets/textNew.dart';
import 'package:taxiapplication/widgets/textOld.dart';

class SubmitOld extends StatefulWidget{
  _SubmitOldState createState() => _SubmitOldState();
}

class _SubmitOldState extends State<SubmitOld>{
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
                      TextNew()
                    ],
                  ),
                  PasswordInput(),
                  LoginConfirm()
                ],
              )
            ],
          ),
      )
    );
  }
}