import 'package:flutter/material.dart';

class TextHint extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20,left: 100.0, right: 80),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset('assets/money.png'),
              Padding(padding: const EdgeInsets.only(left:20)),
              Text('PAY LESS.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top:10),
          ),
          Row(
            children: <Widget>[
              Image.asset('assets/pin.png'),
              Padding(padding: const EdgeInsets.only(left:20)),
              Text('RIGHT IN PLACE.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top:10),
          ),
          Row(
            children: <Widget>[
              Image.asset('assets/slippers.png'),
              Padding(padding: const EdgeInsets.only(left:20)),
              Text('FULL COMFORT.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top:10),
          ),
          Row(
            children: <Widget>[
              Image.asset('assets/speed.png'),
              Padding(padding: const EdgeInsets.only(left:20)),
              Text('JUST IN TIME.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20))
            ],
          ),
        ],
      )
    );
  }
}