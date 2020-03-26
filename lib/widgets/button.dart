import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:taxiapplication/main.dart';
import 'package:taxiapplication/screens/map_page.dart';
import 'package:http/http.dart' as http;
import 'package:taxiapplication/screens/newuser.page.dart';

class ButtonLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin>{
  Future _showAlert (BuildContext context) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Ooops...'),
          content: new Text('Invalid verification code!'),
          actions: <Widget>[
            new FlatButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewUser())), child: new Text("Ok"))
          ],
        )
    );
  }
  String url = "https://pure-taiga-88169.herokuapp.com/auth/verify";
  Future<String> codeResponse (String code, String phone) async{
    var response = await http.post(Uri.encodeFull(url), body: {"code":"$code", "phone":"$phone"});
    int status_v = response.statusCode;
    store['status_v'] = status_v;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 3.0)
        ),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () async{
            await codeResponse(store['code'], store['phone']);
            print(store['status_v']);
            if(store['status_v'] == 200){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainWidget()));
            }
            else{
              _showAlert(context);
            }
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