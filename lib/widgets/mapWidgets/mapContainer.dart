import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:taxiapplication/map_request.dart';
import 'package:global_state/global_state.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:ui' as ui;


const kGoogleApiKey = "AIzaSyBR2yf_lUiNSp44gxeQGNdS3U-4GUKho_U";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
class MapContainer extends KFDrawerContent{
  @override
  State<StatefulWidget> createState() => _MapContainerState();


}

class _MapContainerState extends State<MapContainer>{
  String _mapStyle;
  GoogleMapController mapController;
  Set<Marker> _markers = {};
  Positioned _myLocation;
  Positioned _currentPosition;
  Positioned _allRoute;
  Position _position;
  Geolocator _geolocator;
  static LatLng _initialPosition;
  LatLng _cameraPosition;
  List<LatLng> routeCoords;
   Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  GoogleMapPolyline googleMapPolyline =  new GoogleMapPolyline(apiKey: store['apikey']);

  bool inputsVisible=true;
  bool visibleSearchDestination=false;
  bool visibleSearchCurrent=false;
  bool setFromMapCurrent=true;
  bool setFromMapDestination=false;
  bool ready=false;
  bool zakaz=false;
  bool currentPosition=true;
  bool myLocation=true;
  bool menu=true;
  bool resume=false;
  bool back=false;
  bool sideMenu=false;
  bool allRoute=false;
  LatLngBounds bound;






  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
 //   arrang=result[int.parse((result.length/2).toString().split(".")[0])];
    return result;
  }

  void sendRequest() async {
    String route = await _googleMapsServices.getRouteCoordinates(
        LatLng(store['current'].latitude,store['current'].longitude),
        LatLng(store['distenation'].latitude,store['distenation'].longitude));
    createRoute(route);
    _addMarker("current");
    _addMarker("distenation");
     bound = LatLngBounds(
        southwest: LatLng(store['current'].latitude,store['current'].longitude),
        northeast: LatLng(store['distenation'].latitude,store['distenation'].longitude)
    );
    if (store['distenation'].latitude > store['current'].latitude &&
        store['distenation'].longitude > store['current'].longitude) {
      bound = LatLngBounds(southwest: LatLng(store['current'].latitude,store['current'].longitude), northeast: LatLng(store['distenation'].latitude,store['distenation'].longitude));
    } else if (store['distenation'].longitude > store['current'].longitude) {
      bound = LatLngBounds(
          southwest: LatLng(store['distenation'].latitude, store['current'].longitude),
          northeast: LatLng(store['current'].latitude, store['distenation'].longitude));
    } else if (store['distenation'].latitude > store['current'].latitude) {
      bound = LatLngBounds(
          southwest: LatLng(store['current'].latitude, store['distenation'].longitude),
          northeast: LatLng(store['distenation'].latitude, store['current'].longitude));
    } else {
      bound = LatLngBounds(southwest: LatLng(store['distenation'].latitude,store['distenation'].longitude), northeast: LatLng(store['current'].latitude,store['current'].longitude));
    }
    setState(() {
      mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 0));
      mapController.animateCamera(
        CameraUpdate.zoomOut(),
      );
    });
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }


  void _addMarker( String address)async {
    final Uint8List distenation = await getBytesFromAsset('assets/image/'+address+'.png', 100);
    setState(() {
      _markers.add(
          new Marker(
              markerId: new MarkerId(address),
              position: LatLng(store[address].latitude,store[address].longitude),
              icon: BitmapDescriptor.fromBytes(distenation)

          )
      );
    });
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
      store['current']=new Coordinates(latLng.latitude,latLng.longitude);
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
  //
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
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
        });


  }
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
       bottom: 120,
        right: 10,
        child: new IconButton(
          color: Colors.grey,
          icon:  new Icon(
              Icons.my_location,
              color: Colors.black,
              size: 30.0),
          onPressed: ()async{
            mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_position.latitude, _position.longitude), zoom: 17)));
          },
          iconSize: 30.0,
        ),);
    _allRoute=new Positioned(
      bottom: 210,
      right: 10,
      child: new IconButton(
        color: Colors.black,
        icon:  ImageIcon(AssetImage("assets/image/route.png"),size: 50),
        onPressed: ()async{
          print("aaa");
          setState(() {
            mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 0));
            mapController.animateCamera(
              CameraUpdate.zoomOut(),
            );
          });
        },
        iconSize: 30.0,
      ),
    );
    return Scaffold(
        key: scaffoldKey,
        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Side menu',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/cover.jpg'))),
              ),
              ListTile(
                leading: Icon(Icons.input),
                title: Text('Welcome'),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Profile'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.border_color),
                title: Text('Feedback'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () => {Navigator.of(context).pop()},
              ),
            ],
          ),
        ),//боковое меню
        body:Container( height:mapHeight,
        width: mapWidth,
           child:Stack(children:<Widget>[
             GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 17,
        ),
          polylines: _polyLines,

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
            if(setFromMapCurrent) {
              print("start");
              setState(() {
                  inputsVisible=false;
              });
              print(inputsVisible);
           }
            if(setFromMapDestination){
            }
            },
          //CAMERA MOVING//
          onCameraMove: (CameraPosition position){
           if(setFromMapCurrent) {
             _cameraPosition = position.target;
             print(_cameraPosition);
           }
           if(setFromMapDestination){
             _cameraPosition = position.target;
             print(_cameraPosition);
           }

           },
          //CAMERA MOVE FINISH//
          onCameraIdle: ()async{
           if(setFromMapCurrent) {
             print("finish");
             final coordinates = new Coordinates(
                 _cameraPosition.latitude, _cameraPosition.longitude);
             var addresses = await Geocoder.local.findAddressesFromCoordinates(
                 coordinates);
             var first = addresses.first;
             setState(() {
               store['currentController'].text =
                   first.addressLine.split(",")[0] + ", " +
                       first.addressLine.split(",")[1];
               store['current'] = new Coordinates(
                   _cameraPosition.latitude, _cameraPosition.longitude);
               inputsVisible = true;
             });
             setState(() {
               _markers.add(
                   new Marker(
                       markerId: new MarkerId("current"),
                       position: _cameraPosition
                   )
               );
             });

             print(store['currentController'].text);
             print(inputsVisible);
           }
           if(setFromMapDestination){
             print("finish");
             final coordinates = new Coordinates(
                 _cameraPosition.latitude, _cameraPosition.longitude);
             var addresses = await Geocoder
                 .local
                 .findAddressesFromCoordinates(
                 coordinates
             );
             var first = addresses.first;
             setState(() {
               store['distenationController'].text =
                   first.addressLine.split(",")[0] + ", " +
                       first.addressLine.split(",")[1];
               store['distenation'] = new Coordinates(
                   _cameraPosition.latitude, _cameraPosition.longitude);
             });

             print(store['distenationController'].text);
             print(inputsVisible);
           }
           },
        markers: _markers,
      ),//карта гугл меп
             Visibility(
          child:_myLocation,
          visible: myLocation,
        ),//кнопка что б перейти к моему местоположению
             Visibility(
          child: _currentPosition,
          visible:  currentPosition,
        ),//маркер положения карти
             Visibility(
          visible: inputsVisible,
          child: Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child:  Container(
              height: 100,
              width: mapWidth,
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
                                  back=true;
                                  resume=false;
                                  menu=false;
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
                                  width:mapWidth-50.0,
                                  child: new Text(store['distenationController'].text,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.amber
                                    ),
                                  )),
                              onTap: (){
                                setState(() {
                                  back=true;
                                  resume=false;
                                  menu=false;
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

        ),//контейнер с локациями старта и назначения
             Visibility(
          child: Container(
            height: mapHeight,
            width: mapWidth,
            color: Colors.deepOrange,
              padding: EdgeInsets.all(50),
              child:ListView(
                  children: <Widget>[
                     SearchMapPlaceWidget(
                       apiKey: kGoogleApiKey,
                       location: _initialPosition,
                       radius: 30000,
                        icon: IconData(0xeb3b, fontFamily: 'MaterialIcons'),
                        onSelected: (place) async {
                            final geolocation = await place.geolocation;
                            print(geolocation.coordinates);
                            store['current'] = Coordinates(
                             geolocation.coordinates.latitude,
                            geolocation.coordinates.longitude);
                            store['currentController'].text = await place.description;
                            mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                        target: geolocation.coordinates,
                                        zoom: 17
                                    )
                                )
                            );
                    visibleSearchCurrent = false;
                    },
                     )
                  ]
              )
          ),
          visible: visibleSearchCurrent,
        ),//контейнер с поиском локации старта
             Visibility(
               child: Container(
                   height: mapHeight,
                   width: mapWidth,
                   padding: EdgeInsets.all(50),
                   color: Colors.deepOrange,
                   child:ListView(
                     children: <Widget>[
                       IconButton(
                         icon: Row(
                           children: <Widget>[
                             Icon(Icons.local_taxi,color: Colors.white,),
                             Text("Choose on map")
                           ],
                         ),
                         onPressed:(){
                           setState(() {
                             visibleSearchDestination=false;
                             setFromMapCurrent=false;
                             setFromMapDestination=true;
                             ready=true;
                             resume=true;
                             back=false;
                             menu=false;
                             inputsVisible=false;
                           });
                         } ,
                       ),
                       SearchMapPlaceWidget(
                         apiKey: kGoogleApiKey,
                         location: _initialPosition,
                         radius: 30000,
                         placeholder: "Enter your place",
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
                             back=false;
                             resume=true;
                             allRoute=true;
                             menu=false;
                             setFromMapCurrent=false;
                             currentPosition=false;
                             _cameraPosition=geolocation.coordinates;
                             visibleSearchDestination = false;
                             if (store['current'] != "" && store['distenation'] != "") {
                               print("errrrrr");
                               ready=false;
                               sendRequest();
                               zakaz=true;
                             }
                           });
                           print(allRoute);


                         },
                       ),
                     ],
                   )

               ),
               visible: visibleSearchDestination,
             ),//контейнер с поиском локации назначения
             Visibility(
          child: Positioned(
            child: Container(
              height: 100,
              width: mapWidth,
              child: GestureDetector(
               child: Column(
                 children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.grey,
                    width: mapWidth,
                    child:GestureDetector(
                        child:  Row(
                          children: <Widget>[
                            Icon(
                              Icons.my_location,
                              size: 30,
                            ),
                            Text(
                              store['distenationController'].text,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.amber
                            ),
                            )
                          ],
                        ),
                      onTap: (){
                        setState(() {
                          ready=false;
                          resume=true;
                          back=false;
                          menu=false;
                          visibleSearchDestination=true;
                        });
                        print(allRoute);
                      },
                    ),
                  ),
                 Container(
                   height: 50 ,
                   width: mapWidth,
                   color: Colors.yellow,
                   child:Center(
                     child: FlatButton(
                       child: Text(
                           "READY",
                           style: TextStyle(
                               fontSize: 20,
                               color: Colors.white
                           )
                       ),
                       onPressed: (){
                         if (store['current'] != "" &&
                             store['distenation'] != ""){
                           print("errrrrr");
                           sendRequest();
                           setState(() {
                             menu=false;
                             ready=false;
                             resume=true;
                             back=false;
                             allRoute=true;
                             setFromMapDestination=false;
                             currentPosition=false;
                             zakaz=true;
                             myLocation=false;
                           });
                             }
                         },
                     ),
                   ),
                 )
                 ],
               ),
              ),
            ),
            bottom: 10,
            left: 10,
            right: 10,
          ),
          visible: ready,
        ),//подтверждение локации назначения
             Visibility(
               child: Positioned(
                 bottom: 0,
                 left: 0,
                 right: 0,
                 child: Container(
                   height: 200,
                   width: mapWidth,
                   color: Colors.grey,
                   child: Column(
                     children: <Widget>[
                       Container(
                         width: mapWidth,
                         height: 60,
                         child:SingleChildScrollView(
                             scrollDirection: Axis.horizontal,
                             child: Row(
                                 children: <Widget>[
                                   GestureDetector(
                                     child: Container (
                                       width: 200,
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: <Widget>[
                                           Container(
                                             width: 80,
                                             child: Image.asset("assets/image/type3.png"),
                                           ),
                                           Container(
                                             padding: EdgeInsets.only(top: 7,right: 10),
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                               children: <Widget>[
                                                 Text("hechbeck"),
                                                 Text("45\$")
                                               ],
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                     onTap:()=> print("hechbeck"),
                                   ),
                                   GestureDetector(
                                     child: Container (
                                       width: 200,
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                         children: <Widget>[
                                           Container(
                                             width: 80,
                                             child: Image.asset("assets/image/type2.png"),
                                           ),
                                           Container(
                                             padding: EdgeInsets.only(top: 7,right: 10),
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: <Widget>[
                                                 Text("sedan"),
                                                 Text("55\$")
                                               ],
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                     onTap:()=> print("sedan"),
                                   ),
                                   GestureDetector(
                                     child: Container (
                                       width: 200,
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: <Widget>[
                                           Container(
                                             width: 80,
                                             child: Image.asset("assets/image/type3.png"),
                                           ),
                                           Container(
                                             padding: EdgeInsets.only(top: 7,right: 10),
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: <Widget>[
                                                 Text("universal"),
                                                 Text("65\$")
                                               ],
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                     onTap:()=> print("universal"),
                                   ),

                                 ]
                             )
                         ),
                       ),//вибор типа машини
                       Container(
                         height: 50,
                         padding: EdgeInsets.only(left: 20,right: 20),
                         decoration: BoxDecoration(
                             border: Border(
                                 bottom: BorderSide(
                                     color: Colors.white
                                 ),
                                 top: BorderSide(
                                     color: Colors.white
                                 )
                             )
                         ),
                         child: GestureDetector(

                           child: Row(
                             children: <Widget>[
                               Text(
                                   "45\$"
                               ),
                               Spacer(),
                               Container(
                                 height: 30,
                                 child: FlatButton(
                                   color: Colors.grey,
                                   shape: RoundedRectangleBorder(
                                       borderRadius: new BorderRadius.circular(18.0),
                                       side: BorderSide(color: Colors.black)
                                   ),
                                   child: Text(
                                       "change price"
                                   ),
                                   onPressed: (){print("113");},
                                 ),
                               )
                             ],
                           ),
                         ),
                       ),//измение суми заказа
                       Container(
                         height: 50,
                         padding: EdgeInsets.all(5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             Container(
                               child: Center(
                                 child: Column(
                                   children: <Widget>[
                                     Icon(Icons.attach_money),
                                     Text("money")
                                   ],
                                 ),
                               ),
                             ),
                             Container(
                               child: Center(
                                 child: Column(
                                   children: <Widget>[
                                     Icon(Icons.watch_later),
                                     Text("now")
                                   ],
                                 ),
                               ),
                             ),
                             Container(
                               child: Center(
                                 child: Column(
                                   children: <Widget>[
                                     Icon(Icons.playlist_add),
                                     Text("respect")
                                   ],
                                 ),
                               ),
                             ),
                             ],
                         ),
                       ),//вибор способа платежа, времени подачи машини, додавання побажання
                       Container(
                         height: 40,
                         width: mapWidth,
                         color: Colors.yellowAccent,
                         child: GestureDetector(
                           child: Center(
                             child: Text(
                                 "Order"
                             ),

                           ),

                           onTap: (){
                             showDialog(
                                 context: context,
                                 child:Text(
                                     "Succesfull"
                                 )
                             );
                           },
                         ),
                       ),//подтверджение заказа
                     ],
                   ),
                 ),

          ),
               visible: zakaz,
             ),//оформеления заказ
             Visibility(
          visible: menu,
          child:ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: IconButton(
                  padding: EdgeInsets.only(top: 20),
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed:() => scaffoldKey.currentState.openDrawer(),
                ),
              ),
          ),
        ),//меню
             Visibility(
          visible: resume,
          child:Positioned(
            top: 30,
            left: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  onPressed: (){
                    setState(() {
                      allRoute=false;
                      menu=true;
                      resume=false;
                      ready=false;
                      back=false;
                      zakaz=false;
                      setFromMapCurrent=true;
                      setFromMapDestination=false;
                      myLocation=true;
                      inputsVisible=true;
                      currentPosition=true;
                      inputsVisible=true;
                      _polyLines={};
                      _markers={};
                      store['distenationController'].text="";
                      store['distenation']="";
                      store['current']="";
                      store['currentController'].text="";
                      if(store['currentController'].text=="")
                      {
                        getAdress(_initialPosition);
                      }
                      mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: _initialPosition,
                                  zoom: 17)));

                    });
                  },
                ),
              ),
            ),
          ),
        ),//вернуть всё в начальное положение//
             Visibility(
          visible: back,
          child:Positioned(
            top: 30,
            left: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  onPressed: (){
                    setState(() {
                      allRoute=false;
                      visibleSearchCurrent=false;
                      visibleSearchDestination=false;
                      back=false;
                      resume=false;
                      menu=true;
                    });
                  },
                ),
              ),
            ),
          ),
        ),//назад к вибору по маркеру
             Visibility(
               child:_allRoute,
               visible: allRoute,
             ),//весь маршрут
      ]
    )
      )
    );

  }
  void resumeValue() {


  }
}



