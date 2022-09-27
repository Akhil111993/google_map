//to get location from device

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/geolocoding.dart';

import 'geolocator_controller.dart';

class GeolocatorWidget extends StatefulWidget {
  const GeolocatorWidget({super.key});

  @override
  State<GeolocatorWidget> createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<GeolocatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const GeoCodingWidget()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                //to get actual device location
                try {
                  Position p = await determinePosition();
                  Fluttertoast.showToast(
                      msg: 'lat = ${p.latitude}, lon = ${p.longitude}',
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
              child: const Text('Get current location'),
            ),
            ElevatedButton(
              onPressed: () async {
                //to get last known location/ Can also use location listener with geolocator.
                try {
                  Position? p = await Geolocator.getLastKnownPosition();
                  //to find distance using geolocator package
                  double distanceInMeters = Geolocator.distanceBetween(
                      0, 0, p?.latitude ?? 0, p?.longitude ?? 0);
                  Fluttertoast.showToast(
                      msg:
                          'lat = ${p?.latitude ?? '0'}, lon = ${p?.longitude ?? '0'}, distance from 0,0 = $distanceInMeters',
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
              child: const Text('Get last loc and distance'),
            ),
          ],
        ),
      ),
    );
  }
}
