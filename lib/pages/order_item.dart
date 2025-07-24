import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  String restaurantId;

  OrderItem({super.key, required this.restaurantId});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  void initState() {
    getRestaurant();
    getRestaurantItems();
    super.initState();
  }

  Map<String, dynamic> restaurantData = {};

  getRestaurant() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await firestore
            .collection("restaurant_profile")
            .doc(widget.restaurantId)
            .get();

    Map<String, dynamic> finalData = snapshot.data() as Map<String, dynamic>;
    restaurantData = finalData;

    setState(() {});
  }

  List<DocumentSnapshot> restaurantItems = [];

  getRestaurantItems() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firestore
            .collection("many_restaurant_item")
            .doc(widget.restaurantId)
            .collection("restaurant_items")
            .get();

    restaurantItems.addAll(snapshot.docs);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm Order")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                restaurantData.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Text(
                      restaurantData["restaurantName"],
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
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
            restaurantData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Text(restaurantData["address"]),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              "Recommended for you",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child:
                  restaurantItems.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: restaurantItems.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> finalData =
                              restaurantItems[index].data()
                                  as Map<String, dynamic>;

                          return finalData.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.fastfood,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              Text(finalData["foodName"]),
                                              SizedBox(height: 20),
                                              Text(
                                                "₹${finalData["foodPrice"]}",
                                              ),
                                            ],
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                height: 135,
                                                width: 125,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  child: Image.network(
                                                    finalData["imageURL"],
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 95,
                                                left: 12,
                                                height: 40,
                                                width: 100,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    side: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.green,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                              top:
                                                                  Radius.circular(
                                                                    25,
                                                                  ),
                                                            ),
                                                      ),
                                                      context: context,
                                                      builder: (context) {
                                                        return Column(
                                                          children: [
                                                            Text("data"),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text("ADD"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
    );
  }
}
