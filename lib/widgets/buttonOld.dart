import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:taxiapplication/screens/map_page.dart';
import 'package:taxiapplication/screens/submit_page_old.dart';
import 'package:http/http.dart' as http;

class ButtonOld extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonOldState();
}

class _ButtonOldState extends State<ButtonOld>{
  String url = "http://192.168.223.105:3000/auth/signin";
  Future<String> makeRequest(String session, String phone) async {
    final response = await http.post(Uri.encodeFull(url), body: {"phone":"$session","name":"$phone"});
    print(response.body);
    int status = response.statusCode;
    store['status'] = status;
    print(store['status']);
  }
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
          onPressed: () async{
            await makeRequest(store['cookie'], store['name']);
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