import 'package:e_commerce/core/models/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  late LocationPermission permission;

  Future<void> requestPermission() async {
    permission = await Geolocator.requestPermission();
  }

  Future<Address> getLocation() async {
    if (permission == LocationPermission.denied) {
      await requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placeMarkers =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Address address = Address(
      name: placeMarkers[0].name.toString(),
      locality: placeMarkers[0].locality.toString(),
      street: placeMarkers[0].street.toString(),
      subLocality: placeMarkers[0].subLocality.toString(),
      postalCode: placeMarkers[0].postalCode.toString(),
    );

    print(address);
    return address;
  }
}
