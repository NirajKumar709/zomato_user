import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationAndAddressSelect extends StatefulWidget {
  const LocationAndAddressSelect({super.key});

  @override
  State<LocationAndAddressSelect> createState() =>
      _LocationAndAddressSelectState();
}

class _LocationAndAddressSelectState extends State<LocationAndAddressSelect> {
  GoogleMapController? _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            hintText: "Search for area, street",
            isDense: true,
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(28.6139, 77.2090),
          zoom: 11.0,
        ),
        mapType: MapType.normal,

        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
