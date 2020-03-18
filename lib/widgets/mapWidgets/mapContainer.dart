import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:taxiapplication/widgets/mapWidgets/containerWithInputs.dart';
import 'package:global_state/global_state.dart';

const kGoogleApiKey = "AIzaSyBR2yf_lUiNSp44gxeQGNdS3U-4GUKho_U";
class MapContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MapContainerState();


}

class _MapContainerState extends State<MapContainer>{
  Position _position;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Geolocator _geolocator;
  LatLng _lastMapPosition;
  Positioned _myLocation;
  Positioned _currentPosition;
   CameraPosition _initialCamera = CameraPosition(
    target: LatLng(-20.3000, -40.2990),
    zoom: 16.0000,
  );


  void updateLocation() async {
    try {
      Position newPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));

      setState(() {
        _position = newPosition;
        _initialCamera=CameraPosition(target: LatLng(_position.latitude,_position.longitude),zoom: 14.0000);
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator();
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    checkPermission();
    updateLocation();

    StreamSubscription positionStream = _geolocator.getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        _position = position;
        _lastMapPosition=new LatLng(position.latitude,position.longitude);
        print('Latitude: ${_position != null ? _position.latitude.toString() : '0'},'
            ' Longitude: ${_position != null ? _position.longitude.toString() : '0'}');
      });});

  }
  double zoomVal=5.0;
  void _currentLocation() async{
  LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
  StreamSubscription positionStream =await _geolocator.getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        _position = position;
        _lastMapPosition=new LatLng(position.latitude,position.longitude);
        print('Latitude: ${_position != null ? _position.latitude.toString() : '0'},'
            ' Longitude: ${_position != null ? _position.longitude.toString() : '0'}');
      });});
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_position.latitude, _position.longitude), zoom: 15)));

  }

  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus()
        .then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways)
        .then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)
        .then((status) { print('whenInUse status: $status'); });
  }
  @override
  Widget build(BuildContext context) {
    double mapWidth = MediaQuery.of(context).size.width;
    double mapHeight = MediaQuery.of(context).size.height-40;
    double iconSize = 30.0;
    _currentPosition=new Positioned(
       top: (mapHeight - iconSize)/ 2,
         right: (mapWidth - iconSize)/ 2,
        child: new Icon(Icons.person_pin_circle, size: iconSize)
    );
    _myLocation=new Positioned(
        top: (mapHeight - 150),
        right: 20,
          child: new IconButton(
            color: Colors.grey,
          icon:  new Icon(
              Icons.location_searching,
              color: Colors.black,
              size: iconSize),
          onPressed: _currentLocation,
            iconSize: 30.0,
          ),


    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:Stack(children:<Widget>[
        GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(
            target:LatLng(_position.latitude, _position.longitude)
            , zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
          //CAMERA MOVE START//
          onCameraMoveStarted: (){
          print("start");
          store['visible']=false;
          print(store['visible']);

          },

          //CAMERA MOVE FINISH//
          onCameraIdle: (){
          print("finish");
          print(store['visible']);
          },
        markers: _markers,
      ),
        _myLocation,
        _currentPosition
      ]
    )
      );
  }

}

