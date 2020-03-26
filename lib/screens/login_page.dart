import 'package:flutter/material.dart';
import 'package:taxiapplication/widgets/buttonOld.dart';
import 'package:taxiapplication/widgets/newEmail.dart';
import 'package:taxiapplication/widgets/signin.dart';
import 'package:taxiapplication/widgets/textOld.dart';

class oldUser extends StatefulWidget{
  @override
  _oldUserState createState() => _oldUserState();
}

class _oldUserState extends State<oldUser>{
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
                NewEmail(),
                ButtonOld()
              ],
            )
          ],
        ),
      ),
    );
  }
}
