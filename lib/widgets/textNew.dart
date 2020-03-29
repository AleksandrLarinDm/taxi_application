import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextNew extends StatefulWidget {
  @override
  _TextNewState createState() => _TextNewState();
}

class _TextNewState extends State<TextNew> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 65.0, right: 65.0),
           child: Container(
              width: 280,
              height: 280,
//              decoration: BoxDecoration(
//                  shape: BoxShape.circle,
//                  color: Color.fromRGBO(31,30,34, 3)
//              ),
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/taxi.svg'),
            ),
    );
  }
}