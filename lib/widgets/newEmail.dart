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
      padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          autofocus: false,
          controller: myController,
          keyboardType: TextInputType.numberWithOptions(),
          style: TextStyle(
            color: Colors.black
          ),
          decoration: InputDecoration(
            icon: new Icon(Icons.phone, color: Colors.black,),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              ),
            fillColor: Colors.black,
            labelText: 'Mobile phone',
            labelStyle: TextStyle(
              color: Colors.black
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