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

  Future<String> getSession() async {
    Map<String, String> headers = {"content-type":"text/json"};
    final response = await http.get(Uri.encodeFull(url), headers: headers);
    String json = response.body;
    print(json);
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
//           if(store['status']==200){
//              //Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitPage()));
//            }
//            else{
//              _showAlert(context);
//            }
//            print(store['phone']);
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