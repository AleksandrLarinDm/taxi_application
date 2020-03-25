import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:taxiapplication/utils/wrapper.dart';
import 'utils/class_builder.dart';
import 'screens/auth_page.dart';
import 'screens/calendar_page.dart';
import 'screens/map_page.dart';
import 'dart:io';
import 'package:taxiapplication/screens/newuser.page.dart';

void main() {
  store['current']="";
  store['distenation']="";
  store['currentBool']=true;
  store['distenationBool']=false;
  store['currentController']=new TextEditingController();
  store['distenationController']=new TextEditingController();
  store['status']=0;
  store['apikey']="AIzaSyBR2yf_lUiNSp44gxeQGNdS3U-4GUKho_U";
  ClassBuilder.registerClasses();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: MapPage(),
        debugShowCheckedModeBanner: false
    );
  }
}

class MainWidget extends StatefulWidget{
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;
  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('MapPage'),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/logo.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'SIGN IN',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return AuthPage();
              },
            ));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.red],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
