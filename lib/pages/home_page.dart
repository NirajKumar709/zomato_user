import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as locat;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zomato_user/auth_page/sign_in_page.dart';
import 'package:zomato_user/main.dart';
import 'package:zomato_user/pages/delivery_partner.dart';
import 'package:zomato_user/pages/location_page.dart';
import 'package:zomato_user/pages/order_item.dart';
import 'package:zomato_user/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dataStore = "Getting location... ";

  final List<dynamic> items = [
    {
      "first": "Phone",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0praxNFT7dTQYuQlpiE9nl6gbXzpnY0kSRg&s",
    },
    {
      "first": "Laptop",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVfUrTMlZjzQncknnLg3XoHhlSKsKy7ajVGw&s",
    },
    {
      "first": "Chair",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh0pMQfyxnz4Y2Dtfv2aCfyc8cVLxjewNX8Q&s",
    },
    {
      "first": "Watch",
      "image":
          "https://www.titan.co.in/dw/image/v2/BKDD_PRD/on/demandware.static/-/Sites-titan-master-catalog/default/dw34d84041/images/Titan/Catalog/1698KM02_1.jpg?sw=800&sh=800",
    },
    {
      "first": "Phone",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0praxNFT7dTQYuQlpiE9nl6gbXzpnY0kSRg&s",
    },
    {
      "first": "Laptop",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVfUrTMlZjzQncknnLg3XoHhlSKsKy7ajVGw&s",
    },
    {
      "first": "Chair",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh0pMQfyxnz4Y2Dtfv2aCfyc8cVLxjewNX8Q&s",
    },
    {
      "first": "Watch",
      "image":
          "https://www.titan.co.in/dw/image/v2/BKDD_PRD/on/demandware.static/-/Sites-titan-master-catalog/default/dw34d84041/images/Titan/Catalog/1698KM02_1.jpg?sw=800&sh=800",
    },
  ];

  logOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove("userId").then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });
  }

  @override
  void initState() {
    restaurantFoodItem();
    super.initState();
  }

  List<DocumentSnapshot> foodData = [];

  Future<void> restaurantFoodItem() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    QuerySnapshot restaurantSnapshot =
        await firebase.collection("restaurant_profile").get();

    foodData.addAll(restaurantSnapshot.docs);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: InkWell(
          onTap: () {
            getLocation();
          },
          child: ListTile(
            title: Text(dataStore),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPage(subLocal: dataStore),
                ),
              ).then((value) {
                print("back Data $value");
                dataStore = value;
                setState(() {});
              });
            },
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.currency_rupee_sharp)),
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 12,
          children: [
            Row(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.mic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text("VEG", style: TextStyle(fontSize: 16)),
                    Text("MODE", style: TextStyle(fontSize: 10)),
                    Icon(Icons.power_off_outlined),
                  ],
                ),
              ],
            ),
            Expanded(
              child:
                  foodData.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: foodData.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> finalData =
                              foodData[index].data() as Map<String, dynamic>;

                          List<dynamic> imageUrls = finalData["imageURL"];
                          String? finalImageURL;
                          for (var url in imageUrls) {
                            // print(url);

                            finalImageURL = url;
                          }

                          return finalData.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  height: 315,
                                  width: 330,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ),
                                        child:
                                            finalImageURL!.isEmpty
                                                ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                                : Image.network(
                                                  finalImageURL,
                                                  height: 200,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              finalData["restaurantName"],
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              width: 45,
                                              height: 30,
                                              child: Text(
                                                "4.6*",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(finalData["foodType"]),
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              height: 35,
                                              width: 110,
                                              child: TextButton(
                                                onPressed: () {
                                                  restaurantName =
                                                      finalData["restaurantName"];
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => OrderItem(
                                                            restaurantId:
                                                                foodData[index]
                                                                    .id,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Order Now",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                        },
                      ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: InkWell(
              child: Icon(Icons.delivery_dining, size: 30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryPartner()),
                );
              },
            ),
            label: "Delivery",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(radius: 15),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  getLocation() async {
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

    // covertLocationToName Method Call with argument pass (locationData is argument)
    covertLocationToName(locationData);
  }

  // from Geocoding package (LocationData is dataType, locationData is parameter) Convert latitude and longitude
  covertLocationToName(LocationData locationData) async {
    List<locat.Placemark> placemarks = await locat.placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    dataStore = placemarks[0].subLocality ?? "";

    setState(() {});
  }
}
