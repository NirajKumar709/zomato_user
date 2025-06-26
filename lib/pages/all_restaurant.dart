import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllRestaurant extends StatefulWidget {
  const AllRestaurant({super.key});

  @override
  State<AllRestaurant> createState() => _AllRestaurantState();
}

class _AllRestaurantState extends State<AllRestaurant> {
  List<DocumentSnapshot> dataStore = [];

  @override
  void initState() {
    // TODO: implement initState
    getRestaurant();
    super.initState();
  }

  getRestaurant() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection("restaurant").get();

    dataStore.addAll(snapshot.docs);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Restaurant Here"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child:
                dataStore.isNotEmpty
                    ? ListView.builder(
                      itemCount: dataStore.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> finalData =
                            dataStore[index].data() as Map<String, dynamic>;

                        return ListTile(
                          title: Text(finalData["restaurantName"]),
                          subtitle: Text(finalData["address"]),
                          trailing: Text(finalData["foodType"]),
                        );
                      },
                    )
                    : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
