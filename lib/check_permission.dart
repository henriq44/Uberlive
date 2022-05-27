import 'package:geolocator/geolocator.dart';

class CheckPermission {
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator
        .isLocationServiceEnabled(); //Verifica se o GPS está ativo.
    if (!serviceEnabled) {
      return Future.error('GPS_DISABLED');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('DENIED');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('DENIED_FOREVER');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
