import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:taxiapplication/main.dart';
import 'package:taxiapplication/screens/map_page.dart';
import 'package:http/http.dart' as http;

class ButtonLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin>{
  String url = "http://192.168.223.102:3000/auth/verify";
  Future<String> codeResponse (String code, String phone) async{
    var response = await http.post(Uri.encodeFull(url), body: {"code":"$code", "phone":"$phone"});
    int status_v = response.statusCode;
    store['status_v'] = status_v;
    print(response.statusCode);
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
          onPressed: () async{
            await codeResponse(store['code'], store['phone']);
            if(store['status_v'] == 200){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainWidget()));
            }
            else{
              print('Error');
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