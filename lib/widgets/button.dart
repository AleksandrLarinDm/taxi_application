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
  String url = "http://192.168.223.105:3000/auth/verify";
  Future<String> codeResponse (String code, String phone) async{
    var response = await http.post(Uri.encodeFull(url), body: {"code":"$code", "phone":"$phone"});
    int status_v = response.statusCode;
    print(response.body);
    store['status_v'] = status_v;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 50, left: 50),
      child: Container(
        alignment: Alignment.bottomRight,
        width: MediaQuery.of(context).size.width,
        child: ButtonTheme(
          height: 50.0,
          child: FlatButton(
            color: Color.fromRGBO(31,30,34, 3),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0), side: BorderSide(color: Colors.black, width: 2.0)),
            onPressed: () async{
              await codeResponse(store['code'], store['phone']);
              print(store['status_v']);
              if(store['status_v'] == 200){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapPage()));
              }
              else{
                _showAlert(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "REGISTER",
                  style: TextStyle(
                      color: Color.fromRGBO(150, 150, 150, 3),
                      fontSize: 26,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Icon(
                    Icons.arrow_forward,
                    color: Color.fromRGBO(150, 150, 150, 3),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}