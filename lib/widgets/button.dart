import 'package:flutter/material.dart';
import 'package:taxiapplication/main.dart';
import 'package:taxiapplication/screens/map_page.dart';

class ButtonLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 3.0)
        ),
        child: FlatButton(
          color: Colors.black12,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainWidget()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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