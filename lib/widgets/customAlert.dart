import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      elevation: 0,
      child: _buildChild(context),
    );
  }
  _buildChild(BuildContext context) => Container(
    height: 350,
    decoration: BoxDecoration(
      color: Colors.yellow,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: Column(
        children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset('assets/alert.png'),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12))
          ),
        ),
          SizedBox(height: 24,),
          Text('Error', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Text('An error occured during the process. Try again.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('OK'), textColor: Colors.white,)
            ],
          )
      ],
    ),
  );
}