import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:taxiapplication/screens/submit.page.dart';
import 'package:http/http.dart' as http;

class ButtonNewUser extends StatefulWidget {
  @override
  _ButtonNewUserState createState() => _ButtonNewUserState();
}

class _ButtonNewUserState extends State<ButtonNewUser> {
  Future _showAlert(BuildContext context) async {
    return showDialog(
        context: context,
      child: new AlertDialog(
        title: new Text('Ooops...'),
        content: new Text('User already exists!'),
        actions: <Widget>[
          new FlatButton(onPressed: () => Navigator.pop(context), child: new Text("Ok"))
        ],
      )
    );
  }
  
  String url = "http://192.168.223.102:3000/user";
  Future<String> makeRequest(String phonenumber, String name) async {
    final response = await http.post(Uri.encodeFull(url), body: {"phone":"$phonenumber","name":"$name"});
    print(response.body);
    int status = response.statusCode;
    store['status'] = status;
    print(store['status']);
  }
  Map<String, String> cookies = {};

  Map<String, String> _updateCookie(http.Response response){
    Map<String, String> globalcookie = {};
    String allSetCookie = response.headers['set-cookie'];
    if(allSetCookie != null){
      var setCookies = allSetCookie.split(',');
      for(var setCookie in setCookies){
        var cookies = setCookie.split(';');
        for(var cookie in cookies){
          if (cookie.length > 0) {
            var keyValue = cookie.split('=');
            if (keyValue.length == 2) {
              var key = keyValue[0].trim();
              var value = keyValue[1];
              // ignore keys that aren't cookies
              if (key == 'path' || key == 'expires')
                continue;
              globalcookie[key] = value;
            }
          }
        }
      }
    }
    return globalcookie;
  }

  String _generateCookieHeader(Map<String,String> cookies) {
    String cookie = "";
    for (var key in cookies.keys) {
      if (cookie.length > 0)
        cookie += ";";
      cookie += key + "=" + cookies[key];
    }
    return cookie;
  }

  Future<String> getSession() async {
    Map<String, String> headers = {};
    if (store['cookie'] != null){
      headers['cookie'] = _generateCookieHeader({ 'connect.sid': store['cookie']['connect.sid'] });
    }
    final response = await http.get(Uri.encodeFull(url), headers: headers);
    if (response.headers['set-cookie'] != null) {
      var cookie = _updateCookie(response);
      if (cookie['connect.sid'] != null) {
        store['cookie'] = { 'connect.sid': cookie['connect.sid'] };
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 50, left: 50),
      child: Container(
        alignment: Alignment.center,
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white, width: 2.0)),
        child: RaisedButton(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          focusColor: Colors.white,
          onPressed: ()async{
           await getSession();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}