//to get location from latitude and longitude and vice versa

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:google_maps_webservice/places.dart";

//todo add your google map api key here
const kGoogleApiKey = 'xxxxxxxxxxxxxxxxxxxxxxxxxxx';

class GooglePlaces extends StatefulWidget {
  const GooglePlaces({super.key});

  @override
  State<GooglePlaces> createState() => _GooglePlacesState();
}

class _GooglePlacesState extends State<GooglePlaces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter google places'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                //to get predictions on location to autofill places
                try {
                  Prediction? p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: kGoogleApiKey,
                      mode: Mode.overlay, // Mode.fullscreen
                      language: "en",
                      hint: 'Search',
                      // radius: 10000000, //to search only inside this radius from device
                      types: [],
                      strictbounds:
                          false, //this should be false on overlay mode
                      components: [
                        // Component(Component.country, "fr"),
                        // Component(Component.country, "in"), //to search only india
                        // Component(Component.country, "UK"),
                      ]);
                  Fluttertoast.showToast(
                      msg: p?.description ?? '',
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
              child: const Text('Get predictions for location'),
            ),
          ],
        ),
      ),
    );
  }
}
