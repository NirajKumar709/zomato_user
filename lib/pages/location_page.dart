import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as locat;
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  final String subLocal;

  const LocationPage({super.key, required this.subLocal});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Text("Select a location"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 15,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search for area, street name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                // from Location Package (see Current location) With latitude and longitude
                Location location = Location();

                bool serviceEnabled;
                PermissionStatus permissionGranted;
                LocationData locationData;

                serviceEnabled = await location.serviceEnabled();
                if (!serviceEnabled) {
                  serviceEnabled = await location.requestService();
                  if (!serviceEnabled) {
                    return;
                  }
                }

                permissionGranted = await location.hasPermission();
                if (permissionGranted == PermissionStatus.denied) {
                  permissionGranted = await location.requestPermission();
                  if (permissionGranted != PermissionStatus.granted) {
                    return;
                  }
                }

                locationData = await location.getLocation();
                print(locationData.toString());
                print(locationData.toString());

                // from Geocoding package (LocationData is dataType, locationData is parameter) Convert latitude and longitude
                List<locat.Placemark> placemarks = await locat
                    .placemarkFromCoordinates(
                      locationData.latitude!,
                      locationData.longitude!,
                    );
                String address = placemarks[0].subLocality ?? "";
                Navigator.pop(context, address);
              },
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Use current location"),
                      Text(widget.subLocal.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
