import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapplication/screens/map_page.dart';
import 'package:taxiapplication/screens/submit_page_old.dart';

class ButtonOld extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonOldState();
}

class _ButtonOldState extends State<ButtonOld>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 50, right: 50),
      child: ButtonTheme(
        height: 50,
        child: FlatButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0), side: BorderSide(color: Colors.black, width: 2)),
          color: Color.fromRGBO(31,30,34, 3),
          padding: EdgeInsets.all(0),
          onPressed: (){
            // TODO: add login method
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitOld()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'CONTINUE',
                style: TextStyle(color: Color.fromRGBO(150, 150, 150, 3),fontSize: 26,
                    fontWeight: FontWeight.w500),
              ),
              Icon(
                  Icons.arrow_forward,
                  color: Color.fromRGBO(150, 150, 150, 3)
              )
            ],
          ),
        ),
      )
    );
  }
}