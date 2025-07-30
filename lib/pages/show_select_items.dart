import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zomato_user/main.dart';
import 'package:zomato_user/pages/address_delivery_at_home.dart';
import 'package:zomato_user/pages/location_and_address_select.dart';

class ShowSelectItems extends StatefulWidget {
  const ShowSelectItems({super.key});

  @override
  State<ShowSelectItems> createState() => _ShowSelectItemsState();
}

class _ShowSelectItemsState extends State<ShowSelectItems> {
  String location = "";
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        location = "Location services are disabled.";
      });
      return;
    }

    // Check permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        location = "Location permission denied.";

        setState(() {});
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      location = "Location permissions are permanently denied.";

      setState(() {});
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _latitude = position.latitude;
    _longitude = position.longitude;

    location =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";

    setState(() {});
  }

  void openSettings() {
    Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurantName)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(foodItemImage),
            ),
            title: Text(restaurantItemName),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Items: $selectedItemCount"),
                Text("₹$selectedItemPrice"),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0, 65),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () async {
            await getDataForDelivery();
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (
                    BuildContext context,
                    StateSetter bottomSheetSetState,
                  ) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Select an address',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    dataStore.clear();
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                if (_latitude != null || _longitude != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => LocationAndAddressSelect(
                                            latitude: _latitude!,
                                            longitude: _longitude!,
                                          ),
                                    ),
                                  );
                                  dataStore.clear();
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Location Permission Required",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              openSettings();
                                              getCurrentLocation();

                                              bottomSheetSetState(() {});
                                            },
                                            child: Text("Open Settings"),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  bottomSheetSetState(() {});
                                }
                              },
                              child: Column(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.add),
                                          Text("Add Address"),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios_rounded),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      dataStore.isEmpty
                                          ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                          : ListView.builder(
                                            itemCount: dataStore.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              String dataDocId =
                                                  dataStore[index].id;

                                              Map<String, dynamic> finalData =
                                                  dataStore[index].data()
                                                      as Map<String, dynamic>;

                                              return Card(
                                                child: ListTile(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                AddressDeliveryAtHome(
                                                                  dataDocId:
                                                                      dataDocId,
                                                                ),
                                                      ),
                                                    );
                                                  },
                                                  title: Text(
                                                    "Delivery at Home",
                                                  ),
                                                  subtitle: Text(
                                                    "${finalData["current_address"]}, ${finalData["subLocalityName"]}, ${finalData["localityName"]}",
                                                  ),
                                                  trailing: PopupMenuButton(
                                                    itemBuilder:
                                                        (context) => [
                                                          PopupMenuItem(
                                                            onTap: () {
                                                              deleteDocId(
                                                                docId:
                                                                    dataDocId,
                                                              );
                                                              Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (
                                                                        context,
                                                                      ) =>
                                                                          ShowSelectItems(),
                                                                ),
                                                                (route) =>
                                                                    false,
                                                              );
                                                            },
                                                            child: Text(
                                                              "Delete",
                                                            ),
                                                          ),
                                                        ],
                                                  ),
                                                  leading: Icon(Icons.home),
                                                ),
                                              );
                                            },
                                          ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
            setState(() {});
          },
          child: Text(
            "Select Address at next step",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  List<DocumentSnapshot> dataStore = [];

  getDataForDelivery() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firestore
            .collection("users_profile")
            .doc(globalDocId)
            .collection("adject_address")
            .get();

    dataStore.addAll(snapshot.docs);

    setState(() {});
  }

  deleteDocId({required String docId}) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("users_profile")
        .doc(globalDocId)
        .collection("adject_address")
        .doc(docId)
        .delete();
  }
}
