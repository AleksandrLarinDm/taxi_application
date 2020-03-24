import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:http/http.dart' as http;
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
      child: Container(
        alignment: Alignment.center,
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 2.0)
        ),
        child: FlatButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MapPage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700
                ),
              ),
              Icon(
                  Icons.arrow_forward,
                  color: Colors.white
              )
            ],
          ),
        ),
      ),
    );
  }
}