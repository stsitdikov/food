import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:food/logic/constants.dart';

class Location with ChangeNotifier {
  String _city = 'Поиск';
  String get city => _city;

  void getCityName() async {
    Position position = await getPosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;

    http.Response response =
        await http.get(Uri.parse('$kLocationUrl&geocode=$longitude,$latitude'));

    if (response.statusCode == 200) {
      String data = response.body;
      _city = jsonDecode(data)['response']['GeoObjectCollection']
              ['featureMember'][0]['GeoObject']['metaDataProperty']
          ['GeocoderMetaData']['Address']['Components'][2]['name'];
    } else {
      print(response.statusCode);
      _city = 'Ошибка';
    }
    notifyListeners();
  }

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return position;
  }
}
