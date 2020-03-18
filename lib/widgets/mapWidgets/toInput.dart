import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:global_state/global_state.dart';
import 'package:google_maps_webservice/places.dart';


const kGoogleApiKey = "AIzaSyBR2yf_lUiNSp44gxeQGNdS3U-4GUKho_U";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
class ToInput extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ToInputState();
}

class _ToInputState extends State<ToInput>{
  final FocusNode _focusNode = FocusNode();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Mode _mode = Mode.fullscreen;
  TextEditingController _toController=new TextEditingController();

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }
  void _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    _focusNode.unfocus();
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "us",
      components: [Component(Component.country, "us")],
    );
    _toController.text=p.description;
    print(store['visible']);
  }

  @override
  void initState() {
    _focusNode.addListener(_handlePressButton);

  }
  @override
  Widget build(BuildContext context) {
    double mapHeight = MediaQuery.of(context).size.height-40;
    double mapWidth = MediaQuery.of(context).size.width-80;

    return Container(
      height: 40,
      color: Colors.white,
      padding: EdgeInsets.all(10),

      width: mapWidth,
      child:  new GestureDetector(
        child: new TextField(
          focusNode: _focusNode,
        controller: _toController,),
        onTap: _handlePressButton,
      ),
    );

  }

}