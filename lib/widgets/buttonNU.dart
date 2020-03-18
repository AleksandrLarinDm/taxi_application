import 'package:flutter/material.dart';
import 'package:taxiapplication/screens/submit.page.dart';

class ButtonNewUser extends StatefulWidget {
  @override
  _ButtonNewUserState createState() => _ButtonNewUserState();
}

class _ButtonNewUserState extends State<ButtonNewUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white, width: 3.0)),
        child: FlatButton(
          color: Colors.black12,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitPage()));
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