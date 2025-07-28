import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zomato_user/main.dart';
import 'package:zomato_user/pages/address_delivery_at_home.dart';

class LocationAndAddressSelect extends StatefulWidget {
  double latitude;
  double longitude;

  LocationAndAddressSelect({
    super.key,
    required this.latitude,
    required this.longitude,
  });

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
  void initState() {
    getAddressFromLatLng();
    getUserData();
    super.initState();
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.latitude,
        widget.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        subLocalityName = place.subLocality!;
        localityName = place.locality!;
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
    }

    setState(() {});
  }

  TextEditingController addressController = TextEditingController();

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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 11.0,
              ),
              mapType: MapType.normal,

              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    spacing: 5,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Delivery details"),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 35,
                              color: Colors.red,
                            ),
                            Text(
                              "$subLocalityName, $localityName",
                              style: TextStyle(color: Colors.black),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Additional address details",
                        ),
                      ),
                      Text("E.g. Floor, House no."),
                      SizedBox(height: 10),
                      Text("Receiver details for this address"),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          spacing: 12,
                          children: [
                            Icon(
                              Icons.phone_in_talk,
                              size: 25,
                              color: Colors.black87,
                            ),
                            Text(
                              "$userName, $userPhoneNumber",
                              style: TextStyle(color: Colors.black),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0, 55),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            currentAddressStore(address: addressController.text);

            addressController.clear();
          },
          child: Text(
            "Save address",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  currentAddressStore({required String address}) async {
    if (address.isNotEmpty) {
      currentAddress = address;

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("users_profile")
          .doc(globalDocId)
          .collection("adject_address")
          .doc()
          .set({
            "current_address": address,
            "subLocalityName": subLocalityName,
            "localityName": localityName,
          });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddressDeliveryAtHome()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter address details")));
    }
  }

  getUserData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await firestore.collection("users_profile").doc(globalDocId).get();

    Map<String, dynamic> finalData = snapshot.data() as Map<String, dynamic>;
    userName = finalData["name"];
    userPhoneNumber = finalData["phoneNumber"];

    setState(() {});
  }
}
