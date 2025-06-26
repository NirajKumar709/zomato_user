import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zomato_user/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> dataStore = {};

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  getUserData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("users").doc(globalDocId).get();

    Map<String, dynamic> finalData = snapshot.data() as Map<String, dynamic>;

    dataStore = finalData;
    print("____________________________________________");
    // dataStore.addAll(finalData);

    setState(() {});
  }

  updateUserData({required String name, required String address}) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("users").doc(globalDocId).update({
      "name": name,
      "address": address,
    });

    getUserData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Profile"), centerTitle: true),
      body: Column(
        children: [
          dataStore.isNotEmpty
              ? ListTile(
                title: Text(dataStore["name"]),
                subtitle: Text(dataStore["address"]),
                trailing: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Edit"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              TextEditingController nameEdit =
                                  TextEditingController();
                              TextEditingController addressEdit =
                                  TextEditingController();

                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      TextFormField(
                                        controller: nameEdit,
                                        decoration: InputDecoration(
                                          hintText: "Name",
                                        ),
                                      ),
                                      TextFormField(
                                        controller: addressEdit,
                                        decoration: InputDecoration(
                                          hintText: "Address",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      updateUserData(
                                        name: nameEdit.text,
                                        address: addressEdit.text,
                                      );
                                      dataStore.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Save"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ];
                  },
                ),
              )
              : Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
