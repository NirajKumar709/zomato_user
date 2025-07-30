import 'package:flutter/material.dart';
import 'package:zomato_user/pages/show_select_items.dart';

import '../main.dart';

class AddressDeliveryAtHome extends StatefulWidget {
  String dataDocId;

  AddressDeliveryAtHome({super.key, required this.dataDocId});

  @override
  State<AddressDeliveryAtHome> createState() => _AddressDeliveryAtHomeState();
}

class _AddressDeliveryAtHomeState extends State<AddressDeliveryAtHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantName),
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ShowSelectItems()),
                (route) => false,
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ),
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
          onPressed: () {},
          child: Text(
            "Add Payment Method",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
