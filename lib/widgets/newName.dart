import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';

class NewName extends StatefulWidget{
  @override
  _NewNameState createState() => _NewNameState();
}

class _NewNameState extends State<NewName>{
  String name = "";
  TextEditingController myController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: myController,
          style: TextStyle(
            color: Color.fromRGBO(246, 238, 223, 1)
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            fillColor: Color.fromRGBO(245, 123, 81, 1),
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Color.fromRGBO(246, 238, 223, 1)
            ),
          ),
          onChanged: (text){
            name = myController.text;
            store['name'] = name.toString();
          },
        ),
      ),
    );
  }
}