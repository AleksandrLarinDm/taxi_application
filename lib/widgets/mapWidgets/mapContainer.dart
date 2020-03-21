import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:taxiapplication/map_request.dart';
import 'package:global_state/global_state.dart';
import 'package:google_maps_webservice/places.dart';


const kGoogleApiKey = "AIzaSyBR2yf_lUiNSp44gxeQGNdS3U-4GUKho_U";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
class MapContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MapContainerState();


}

class _MapContainerState extends State<MapContainer>{
  String _mapStyle;
  GoogleMapController mapController;
  Set<Marker> _markers = {};
  Positioned _myLocation;
  Positioned _currentPosition;
  Geolocator _geolocator;
  Position _position;
  static LatLng _initialPosition;
  LatLng _cameraPosition;
  List<LatLng> routeCoords;
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  bool visible=true;
  bool visibleSearchDestination=false;
  bool visibleSearchCurrent=true;

  Set<Polyline> get polyLines => _polyLines;
  GoogleMapPolyline googleMapPolyline =  new GoogleMapPolyline(apiKey: store['apikey']);





  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }
  void sendRequest() async {
    String route = await _googleMapsServices.getRouteCoordinates(
        LatLng(store['current'].latitude,store['current'].longitude),LatLng(store['distenation'].latitude,store['distenation'].longitude));
    createRoute(route);
    _addMarker(store['distenation'],"distenation");
  }
  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
        polylineId: PolylineId("reeeeeer"),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
    });

  }
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }
  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high).timeout(new Duration(seconds: 5));
  }
  getAdress(LatLng latLng)async{
    final coordinates = new Coordinates(latLng.latitude,latLng.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      store['currentController'].text=first.addressLine;
    });

  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
      print(string+"/////////////");
    });
    _geolocator = Geolocator();
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    store['currentController'].text="";
    checkPermission();
    StreamSubscription positionStream = _geolocator.getPositionStream(locationOptions).listen((Position position) {
       setState(() {
            _position = position;
            _initialPosition = LatLng(_position.latitude, _position.longitude);
       });
       if(store['currentController'].text=="")
       {
         getAdress(_initialPosition);
       }
         print("/////////////////");
        });


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
    double mapHeight = MediaQuery.of(context).size.height;
    double iconSize = 50.0;
    _currentPosition=new Positioned(
       top: (mapHeight-iconSize - iconSize)/ 2,
         right: (mapWidth - iconSize)/ 2,
        child: new Icon(Icons.person_pin_circle, size: iconSize)
    );
    _myLocation=new Positioned(
        top: (mapHeight - 200),
        right: 20,
        child: new IconButton(
          color: Colors.grey,
          icon:  new Icon(
              Icons.my_location,
              color: Colors.black,
              size: iconSize),
          onPressed: ()async{
            mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_position.latitude, _position.longitude), zoom: 17)));
          },
          iconSize: 20.0,
        ),);
    return Container(
      height:mapHeight,
      width: mapWidth,
      child:Stack(children:<Widget>[
        GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 17,
        ),
          polylines: polyLines,

          myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapController=controller;
          mapController.setMapStyle(_mapStyle);

          setState(() {
          });
        },
          //CAMERA MOVE START//
          onCameraMoveStarted: (){
          print("start");
          setState(() {
            visible=false;
          });
          print(visible);
          },
          //CAMERA MOVING//
          onCameraMove: (CameraPosition position){
            _cameraPosition=position.target;
            print(_cameraPosition);
            },
          //CAMERA MOVE FINISH//
          onCameraIdle: ()async{
          print("finish");
          final coordinates = new Coordinates(_cameraPosition.latitude,_cameraPosition.longitude);
          var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
          var first = addresses.first;
          setState(() {
            store['currentController'].text=first.addressLine.split(",")[0]+", "+first.addressLine.split(",")[1];
            visible=true;
          });
          store['current']=new Coordinates(_cameraPosition.latitude,_cameraPosition.longitude);
          setState(() {_markers.add(
              new Marker(
                  markerId: new MarkerId("current"),
                position: _cameraPosition
              )
          );});
          print("${first.featureName} : ${first.addressLine}");
          print("${first.adminArea} : ${first.subAdminArea}");
          print("${first.subThoroughfare} : ${first.subLocality}");

          print(store['currentController'].text);
          print(visible);
          },
        markers: _markers,
      ),
        _myLocation,
        _currentPosition,
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: visible,
          child:  Container(
            height: 100,
            width: mapWidth,
            margin: EdgeInsets.only(top:mapHeight-100,left: 10,right: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  decoration:  BoxDecoration(
                    color: const Color(0xff7c94b6),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: mapWidth,
                    child:Row(
                        children: <Widget>[
                          new Icon(Icons.my_location),
                          new GestureDetector( child:Container(
                            width:mapWidth-50.0,
                            child: new Text(store['currentController'].text,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.amber
                              ),
                            ),),
                            onTap: (){
                              setState(() {
                              visibleSearchCurrent=true;
                              });
                            },
                          ),
                        ])
                ),
                Container(
                  height: 40,
                  decoration:  BoxDecoration(
                  color: const Color(0xff7c94b6),
                  border: Border.all(
                      color: Colors.black,
                      width: 2,
                      ),
                  borderRadius: BorderRadius.circular(12),
                  ),
                  width: mapWidth,
                  child:Row(
                      children: <Widget>[
                     new Icon(Icons.local_taxi),
                    new GestureDetector(
                      child:Container(
                        color: Colors.black,
                          width:mapWidth-50.0,
                          child: new Text(store['distenationController'].text,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.amber
                      ),
                        )),
                    onTap: (){
                      setState(() {
                        visibleSearchDestination=true;
                      });
                    },
                  ),
                      ])
                )
              ],
            ),
          ),

        ),
        Visibility(
          child: Container(
            height: mapHeight,
            width: mapWidth,
            color: Colors.deepOrange,
                 child:Positioned(
                   top:60,

                   child:  SearchMapPlaceWidget(
              apiKey: kGoogleApiKey,
              location: _initialPosition,
              radius: 30000,
              onSelected: (place) async {
                  final geolocation = await place.geolocation;
                  print(geolocation.coordinates);
                  store['current'] = Coordinates(
                      geolocation.coordinates.latitude,
                      geolocation.coordinates.longitude);
                  store['currentController'].text = await place.description;
                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: geolocation.coordinates, zoom: 17)));
                  setState(() {
                    if (store['current'] != "" && store['distenation'] != "") {
                      print("errrrrr");
                      sendRequest();
                    }
                  });
                visibleSearchCurrent = false;
              },
            ),
                 )
          ),

          visible: visibleSearchCurrent,
        ),
        Visibility(child: Container(
           height: mapHeight,
            width: mapWidth,
            padding: EdgeInsets.all(50),
            color: Colors.deepOrange,
               child: SearchMapPlaceWidget(
              apiKey: kGoogleApiKey,
              location: _initialPosition,
              radius: 30000,
              onSelected: (place) async {
                final geolocation = await place.geolocation;
                  print(geolocation.coordinates);
                  store['distenation'] = Coordinates(
                      geolocation.coordinates.latitude,
                      geolocation.coordinates.longitude);
                  store['distenationController'].text = await place.description;
                  mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: geolocation.coordinates,
                              zoom: 17)));
                  setState(() {
                    if (store['current'] != "" && store['distenation'] != "") {
                      print("errrrrr");
                      sendRequest();
                    }
                  });
                visibleSearchDestination = false;

              },
            ),

        ),
          visible: visibleSearchDestination,
        )
      ]
    )
    );

  }


}



