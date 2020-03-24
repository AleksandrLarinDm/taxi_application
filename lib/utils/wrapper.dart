import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:taxiapplication/screens/map_page.dart';
import 'package:taxiapplication/screens/newuser.page.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    if(store['cookie'] != null){
      return MapPage();
    }
    else
      return NewUser();
  }
}