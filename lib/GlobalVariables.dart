library my_prj.globals;

import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';


String firstPlayerDepartment = "";
String firstPlayerName = "";
String secondPlayerDepartment = "";
String secondPlayerName = "";
String thirdPlayerDepartment = "";
String thirdPlayerName = "";
String fourthPlayerDepartment = "";
String fourthPlayerName = "";

Future<String> getUserLocation() async {
  LocationData myLocation;
  String error;
  String _currentAddress;
  Location location = new Location();
  try {
    myLocation = await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      error = 'please grant permission';
      print(error);
    }
    if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
      error = 'permission denied- please enable it from app settings';
      print(error);
    }
    myLocation = null;
  }
  final coordinates = new Coordinates(myLocation.latitude, myLocation.longitude);
  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  _currentAddress = ' ${first.addressLine}';
  return _currentAddress;
}
