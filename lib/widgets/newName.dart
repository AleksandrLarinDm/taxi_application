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
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: myController,
          style: TextStyle(
            color: Color.fromRGBO(246, 238, 223, 1)
          ),
          decoration: InputDecoration(
            icon: new Icon(Icons.account_circle, color: Colors.black),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
            ),
            fillColor: Color.fromRGBO(245, 123, 81, 1),
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.black
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