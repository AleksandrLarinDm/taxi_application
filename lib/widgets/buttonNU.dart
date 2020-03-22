import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:taxiapplication/screens/submit.page.dart';
import 'package:http/http.dart' as http;

class ButtonNewUser extends StatefulWidget {
  @override
  _ButtonNewUserState createState() => _ButtonNewUserState();
}

class _ButtonNewUserState extends State<ButtonNewUser> {
  String url = "http://192.168.223.102:3000/auth/signup";
  Future<String> makeRequest(String phonenumber, String name) async {
    final response = await http.post(Uri.encodeFull(url), body: {"phone":"$phonenumber","name":"$name"});
    int status = response.statusCode;
    store['status'] = status;
    print(store['status']);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white, width: 3.0)),
        child: FlatButton(
          onPressed: ()async{
           await makeRequest(store['phone'], store['name']);
           if(store['status']==200){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitPage()));
            }
            else{
              print("Error");
            }
            print(store['phone']);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Submit',
                style: TextStyle(
                  color: Color.fromRGBO(246, 238, 223, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Color.fromRGBO(246, 238, 223, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}