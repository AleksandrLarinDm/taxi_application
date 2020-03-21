import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';

class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  String code = "";
  TextEditingController myController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: myController,
          keyboardType: TextInputType.number,
          style: TextStyle(
            color: Color.fromRGBO(246, 238, 223, 1),
          ),
          obscureText: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            labelText: 'Enter code here',
            labelStyle: TextStyle(
              color: Color.fromRGBO(246, 238, 223, 1),
            ),
          ),
          onChanged: (text){
            code = myController.text;
            store['code'] = text.toString();
          },
        ),
      ),
    );
  }
}