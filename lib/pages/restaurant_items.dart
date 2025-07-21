import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zomato_user/main.dart';

class RestaurantItems extends StatefulWidget {
  final String itemDocId;
  final String ownerDocId;

  const RestaurantItems({
    super.key,
    required this.itemDocId,
    required this.ownerDocId,
  });

  @override
  State<RestaurantItems> createState() => _RestaurantItemsState();
}

class _RestaurantItemsState extends State<RestaurantItems> {
  List<DocumentSnapshot> dataStore = [];

  @override
  void initState() {
    // TODO: implement initState
    getRestaurantName();
    getItems();
    super.initState();
  }

  getItems() async {
    Future.delayed(Duration(seconds: 1), () async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot =
          await firestore
              .collection("restaurant")
              .doc(widget.itemDocId)
              .collection("restaurant_items")
              .get();

      dataStore.addAll(snapshot.docs);

      setState(() {});
    });
  }

  Map<String, dynamic> appBarData = {};

  getRestaurantName() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot1 =
        await firestore.collection("restaurant").doc(widget.itemDocId).get();

    Map<String, dynamic> finalData1 = snapshot1.data() as Map<String, dynamic>;

    appBarData.addAll(finalData1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            appBarData.isNotEmpty
                ? Text(appBarData["restaurantName"])
                : Center(child: CircularProgressIndicator()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dataStore.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> finalData =
                    dataStore[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(finalData["foodName"]),
                    subtitle: Text(finalData["foodPrice"]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        orderItems();
                      },
                      child: Text("Order"),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(finalData["imageURL"]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Payment"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "ADD"),
        ],
      ),
    );
  }

  orderItems() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("temp").doc(globalDocId).set({
      "ownerId": widget.ownerDocId,
      "itemDocId": widget.itemDocId,
    });
  }
}
