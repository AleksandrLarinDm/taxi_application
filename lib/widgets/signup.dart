import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 20),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'WELCOME',
            style: TextStyle(
              color: Colors.black,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          )),
    );
  }
}