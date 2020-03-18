import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kf_drawer/kf_drawer.dart';
import 'package:taxiapplication/widgets/mapWidgets/containerWithInputs.dart';
import 'package:taxiapplication/widgets/mapWidgets/mapContainer.dart';

class MapPage extends KFDrawerContent {
  MapPage({
    Key key,
  });
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: <Widget>[

          MapContainer(),
          ContainerWithInputs(),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            child: Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: widget.onMenuPressed,
              ),
            ),
          ),
        ],
      ),

    );
  }




}