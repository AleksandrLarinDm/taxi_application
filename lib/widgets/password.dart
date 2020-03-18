import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(
            color: Color.fromRGBO(246, 238, 223, 1),
          ),
          obscureText: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            labelText: 'Code',
            labelStyle: TextStyle(
              color: Color.fromRGBO(246, 238, 223, 1),
            ),
          ),
        ),
      ),
    );
  }
}