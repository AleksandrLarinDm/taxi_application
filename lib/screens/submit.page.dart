import 'package:flutter/material.dart';
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
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.red]),
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
                  PasswordInput(),
                  ButtonLogin()
                ],
              )
            ],
          ),
        ),
      );
  }
}