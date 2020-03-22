import 'package:flutter/material.dart';

class TextNew extends StatefulWidget {
  @override
  _TextNewState createState() => _TextNewState();
}

class _TextNewState extends State<TextNew> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 45.0),
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              height: 80,
            ),
            Center(
              child: Text(
                '   Welcome\nto White taxi!',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.black38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}