import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextOld extends StatefulWidget {
  @override
  _TextOldState createState() => _TextOldState();
}

class _TextOldState extends State<TextOld> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, left: 50.0),
      child: Container(
        padding: EdgeInsets.only(top: 20),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white
        ),
        alignment: Alignment.center,
        child: Image.asset('assets/taxi.png'),
    )
    );
  }
}