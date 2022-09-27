//to get location from latitude and longitude and vice versa

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';

import 'flutter_google_places.dart';

class GeoCodingWidget extends StatefulWidget {
  const GeoCodingWidget({super.key});

  @override
  State<GeoCodingWidget> createState() => _GeoCodingWidgetState();
}

class _GeoCodingWidgetState extends State<GeoCodingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geocoding'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const GooglePlaces()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                //to get lat and lon from address. May get more than one address sometimes
                try {
                  List<Location> locations =
                      await locationFromAddress("Gronausestraat 710, Enschede");
                  var loc = locations.first;
                  Fluttertoast.showToast(
                      msg:
                          'lat = ${loc.latitude}, lon = ${loc.longitude}, timestamp = ${loc.timestamp}',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: e.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text('Get lat and lon from address'),
            ),
            ElevatedButton(
              onPressed: () async {
                //to get address from lat and lon. There will be more than one address. Here I will only use first one
                try {
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(52.2165157, 6.9437819);
                  var place = placemarks.first;

                  Fluttertoast.showToast(
                      msg:
                          'Country = ${place.country}, locality = ${place.locality}, sublocality = ${place.subLocality}, , street = ${place.street}',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: e.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text('Get address from lat and lon'),
            ),
          ],
        ),
      ),
    );
  }
}
