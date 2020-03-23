import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kf_drawer/kf_drawer.dart';
import 'package:taxiapplication/widgets/mapWidgets/mapContainer.dart';

class MapPage extends StatefulWidget {
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
        ],
      ),
    );
  }
}