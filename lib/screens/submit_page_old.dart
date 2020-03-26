import 'package:flutter/material.dart';
import 'package:taxiapplication/widgets/login_confirmation.dart';
import 'package:taxiapplication/widgets/password.dart';
import 'package:taxiapplication/widgets/signin.dart';
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
                      SignIn(),
                      TextOld()
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