import 'package:flutter/material.dart';
import 'package:taxiapplication/screens/map_page.dart';

class LoginConfirm extends StatefulWidget{
  @override
  _LoginConfirmState createState() => _LoginConfirmState();
}

class _LoginConfirmState extends State<LoginConfirm>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, right: 50, left: 50),
      child: ButtonTheme(
        height: 50.0,
        child: FlatButton(
          color: Color.fromRGBO(31,30,34, 3),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0), side: BorderSide(color: Colors.black, width: 2.0)),
          focusColor: Colors.white,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "CONFIRM",
                style: TextStyle(
                    color: Color.fromRGBO(150, 150, 150, 3),
                    fontSize: 26,
                    fontWeight: FontWeight.w500
                ),
              ),
              Icon(
                  Icons.done,
                  color: Color.fromRGBO(150, 150, 150, 3)
              )
            ],
          ),
        ),
      ),
    );
  }
}