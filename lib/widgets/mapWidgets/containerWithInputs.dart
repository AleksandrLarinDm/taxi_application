import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:taxiapplication/widgets/mapWidgets/currentInput.dart';
import 'package:taxiapplication/widgets/mapWidgets/mapContainer.dart';
import 'package:taxiapplication/widgets/mapWidgets/toInput.dart';
import 'package:global_state/global_state.dart';

const kGoogleApiKey = "AIzaSyBR2yf_lUiNSp44gxeQGNdS3U-4GUKho_U";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
class ContainerWithInputs extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _ContainerWithInputsState();
}

class _ContainerWithInputsState extends State<ContainerWithInputs> {

  @override
  Widget build(BuildContext context){
  double mapHeight = MediaQuery.of(context).size.height-40;
  double mapWidth = MediaQuery.of(context).size.width-40;
  return Visibility(
    child:  Container(
    height: 100,
    width: mapWidth,
    color: Colors.blueGrey,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(top:mapHeight-100,left: 50,right: 50),
    child: Column(
      children: <Widget>[
        CurrentInput(),
        ToInput()
      ],
    ),
    ),
    visible: store['visible'],

    );
  }

}