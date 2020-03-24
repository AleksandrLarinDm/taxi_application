import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';

class NewEmail extends StatefulWidget{
  @override
  _NewEmailState createState() => _NewEmailState();
}

class _NewEmailState extends State<NewEmail>{
  String phone = "";
  TextEditingController myController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          autofocus: false,
          controller: myController,
          keyboardType: TextInputType.numberWithOptions(),
          style: TextStyle(
            color: Color.fromRGBO(246, 238, 223, 1)
          ),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
            fillColor: Color.fromRGBO(245, 123, 81, 1),
            labelText: 'Mobile phone',
            labelStyle: TextStyle(
              color: Color.fromRGBO(246, 238, 223, 1)
            )
          ),
          onChanged: (text){
            phone = myController.text;
            store['phone']=phone;
        },
        ),
      ),
    );
  }
}