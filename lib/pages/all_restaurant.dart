import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllRestaurant extends StatefulWidget {
  const AllRestaurant({super.key});

  @override
  State<AllRestaurant> createState() => _AllRestaurantState();
}

class _AllRestaurantState extends State<AllRestaurant> {
  List<DocumentSnapshot> dataStore = [];

  Stream<DocumentSnapshot> getRestaurant() async* {
    Future.delayed(Duration(seconds: 3), () {});
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection("restaurant").get();

    dataStore.addAll(snapshot.docs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Restaurant Here"), centerTitle: true),
      body: Expanded(
        child: StreamBuilder(
          stream: getRestaurant(),
          builder: (context, snapshot) {
            return dataStore.isNotEmpty
                ? ListView.builder(
                  itemCount: dataStore.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> finalData =
                        dataStore[index].data() as Map<String, dynamic>;

                    return ListTile(
                      title: Text(finalData["restaurantName"]),
                      subtitle: Text(finalData["address"]),
                      trailing: Text(finalData["foodType"]),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(finalData["imageURL"]),
                      ),
                    );
                  },
                )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
