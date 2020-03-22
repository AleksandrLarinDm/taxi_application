import 'package:flutter/material.dart';

class TextOld extends StatefulWidget {
  @override
  _TextOldState createState() => _TextOldState();
}

class _TextOldState extends State<TextOld> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                'We are glad\nto see you again!',
                style: TextStyle(
                  fontSize: 24,
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