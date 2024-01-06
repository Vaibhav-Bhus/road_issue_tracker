import 'dart:developer';

// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // static Future<String> getCurrentLocation() async {
  //   Position newPosition = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   List<Placemark> placeMarks = await placemarkFromCoordinates(
  //     newPosition.latitude,
  //     newPosition.longitude,
  //   );

  //   Placemark placeMark = placeMarks[0];

  //   String completeAddress =
  //       '${placeMark.subThoroughfare} ${placeMark.thoroughfare}, ${placeMark.subLocality} ${placeMark.locality}, ${placeMark.subAdministrativeArea}, ${placeMark.administrativeArea} ${placeMark.postalCode}, ${placeMark.country}';
  //   log(completeAddress);
  //   return "";
  // }
  Future<bool>checkForLocationPermission()async{
    var status = await Permission.location.status;

    if (status.isDenied) {
      var result = await Permission.location.request();

      if (result.isDenied) {
        return false;
      }
    }
    return true;
  }
  Future<Position?> getCurrentLocation() async {
    

    try {
      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return newPosition;

      // List<Placemark> placeMarks = await placemarkFromCoordinates(
      //   newPosition.latitude,
      //   newPosition.longitude,
      // );

      // Placemark placeMark = placeMarks[0];

      // String completeAddress =
      //     '${placeMark.subThoroughfare} ${placeMark.thoroughfare}, ${placeMark.subLocality} ${placeMark.locality}, ${placeMark.subAdministrativeArea}, ${placeMark.administrativeArea} ${placeMark.postalCode}, ${placeMark.country}';

      // log(completeAddress);
      // return completeAddress;
    } catch (e) {
      log("Error getting location: $e");
      return null;
    }
  }
}
