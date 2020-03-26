import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:http/http.dart' as http;
import 'package:taxiapplication/screens/login_page.dart';
import 'package:taxiapplication/screens/map_page.dart';

class ScndTime extends StatefulWidget{
  @override
  _ScndTimeState createState() => _ScndTimeState();
}

class _ScndTimeState extends State<ScndTime>{
  @override
  Widget build(BuildContext context) {
    String url = "http://192.168.223.102:3000/user";
    return Padding(
      padding: EdgeInsets.only(top: 40, right: 50, left: 50),
      child: ButtonTheme(
        height: 70.0,
        child: FlatButton(
          color: Colors.white,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0), side: BorderSide(color: Colors.black, width: 2.0)),
          focusColor: Colors.white,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> oldUser()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500
                ),
              ),
              Icon(
                  Icons.arrow_forward,
                  color: Colors.black
              )
            ],
          ),
        ),
      ),
    );
  }
}