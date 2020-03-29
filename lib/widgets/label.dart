import 'package:flutter/material.dart';

class Label extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      color: Color.fromRGBO(31,30,34, 3),
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('WHITE ', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 34)
          ),
          Text('TAXI', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(100,100,100, 3), fontWeight: FontWeight.w500, fontSize: 34)
          )
        ],
      ),
    );
  }
}