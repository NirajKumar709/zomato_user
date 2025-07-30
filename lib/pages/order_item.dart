import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zomato_user/pages/show_select_items.dart';

import '../main.dart';

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
                                                    foodPrices =
                                                        finalData["foodPrice"];
                                                    updateFoodPrice =
                                                        foodPrices;

                                                    foodItemImage =
                                                        finalData["imageURL"];

                                                    restaurantItemName =
                                                        finalData["foodName"];

                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                              top:
                                                                  Radius.circular(
                                                                    20,
                                                                  ),
                                                            ),
                                                      ),
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                          builder: (
                                                            BuildContext
                                                            context,
                                                            StateSetter
                                                            bottomSheetSetState,
                                                          ) {
                                                            return Container(
                                                              height: 400,
                                                              padding:
                                                                  EdgeInsets.all(
                                                                    16,
                                                                  ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // Title
                                                                  Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundImage:
                                                                            NetworkImage(
                                                                              finalData["imageURL"],
                                                                            ),
                                                                        radius:
                                                                            24,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            12,
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(
                                                                          finalData["foodName"],
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        icon: Icon(
                                                                          Icons
                                                                              .close,
                                                                        ),
                                                                        onPressed: () {
                                                                          count =
                                                                              1;
                                                                          Navigator.pop(
                                                                            context,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 16,
                                                                  ),

                                                                  Spacer(),

                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                8,
                                                                              ),
                                                                        ),
                                                                        child: Row(
                                                                          children: [
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                Icons.remove,
                                                                                color:
                                                                                    Colors.red,
                                                                              ),
                                                                              onPressed: () async {
                                                                                await decrement();
                                                                                selectedItemCount =
                                                                                    count.toString();
                                                                                bottomSheetSetState(
                                                                                  () {},
                                                                                );
                                                                              },
                                                                            ),
                                                                            Text(
                                                                              "$count",
                                                                              style: TextStyle(
                                                                                fontSize:
                                                                                    16,
                                                                              ),
                                                                            ),
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                Icons.add,
                                                                                color:
                                                                                    Colors.red,
                                                                              ),
                                                                              onPressed: () async {
                                                                                await increment();
                                                                                selectedItemCount =
                                                                                    count.toString();
                                                                                bottomSheetSetState(
                                                                                  () {},
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            12,
                                                                      ),
                                                                      Expanded(
                                                                        child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                8,
                                                                              ),
                                                                            ),
                                                                            padding: EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  15,
                                                                            ),
                                                                          ),
                                                                          onPressed: () {
                                                                            selectedItemPrice =
                                                                                updateFoodPrice!;

                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder:
                                                                                    (
                                                                                      context,
                                                                                    ) =>
                                                                                        ShowSelectItems(),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: Text(
                                                                            "Add item ₹$updateFoodPrice",
                                                                            style: TextStyle(
                                                                              fontSize:
                                                                                  16,
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
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

  String? foodPrices;

  int count = 1;
  String? updateFoodPrice;

  increment() {
    count++;

    int priceConvertInt = int.parse(foodPrices!);
    var multipleFoodPrice = priceConvertInt * count;
    updateFoodPrice = multipleFoodPrice.toString();

    setState(() {});
  }

  decrement() {
    if (count > 1) {
      count--;

      int priceConvertInt = int.parse(updateFoodPrice!);
      int foodPricesConvertInt = int.parse(foodPrices!);
      var multipleFoodPrice = priceConvertInt - foodPricesConvertInt;
      updateFoodPrice = multipleFoodPrice.toString();
    }

    setState(() {});
  }
}
