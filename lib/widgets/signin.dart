import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'SIGN IN',
            style: TextStyle(
              color: Colors.black,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          )
      ),
    );
  }
}