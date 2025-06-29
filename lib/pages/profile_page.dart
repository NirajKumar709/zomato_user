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

    setState(() {});
  }

  updateUserData({
    required String name,
    required String address,
    required String phoneNumber,
  }) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("users").doc(globalDocId).update({
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
    });

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 12,
          children: [
            dataStore.isNotEmpty
                ? CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(dataStore["imageURL"]),
                )
                : Center(child: CircularProgressIndicator()),
            Text("Your Profile"),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title:
                dataStore.isNotEmpty
                    ? Row(
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(dataStore["imageURL"]),
                        ),
                        Text(dataStore["name"] + " Profile"),
                      ],
                    )
                    : Center(child: CircularProgressIndicator()),
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
                          TextEditingController phoneEdit =
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
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneEdit,
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
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
                                    phoneNumber: phoneEdit.text,
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
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child:
                  dataStore.isNotEmpty
                      ? ListTile(
                        title: Text(dataStore["name"]),
                        subtitle: Text(dataStore["phoneNumber"].toString()),
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(dataStore["imageURL"]),
                        ),
                        trailing: Text(dataStore["address"]),
                      )
                      : Center(child: CircularProgressIndicator()),
            ),

            // dataStore.isNotEmpty
            //     ? Column(
            //       children: [
            //         Text("Name: " + dataStore["name"]),
            //         Text("Address: " + dataStore["address"]),
            //         Text(
            //           "PhoneNumber: " + dataStore["phoneNumber"].toString(),
            //         ),
            //       ],
            //     )
            //     : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
