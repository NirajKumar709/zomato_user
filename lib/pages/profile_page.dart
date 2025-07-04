import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  updateImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Select a image")));
    } else {
      File file = File(pickedFile.path);

      final storageRef = FirebaseStorage.instance.ref();
      final childRef = storageRef.child(
        "user_image/${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      await childRef.putFile(file).then((p0) async {
        String downloadURL = await childRef.getDownloadURL();

        print(downloadURL);
        print("_____________________________________");

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        firestore.collection("users").doc(globalDocId).update({
          "imageURL": downloadURL,
        });

        imageURL = downloadURL;

        getUserData();

        setState(() {});

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Image Updated Successfully")));
      });
    }
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
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                dataStore["imageURL"],
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  updateImage();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
          ),
        ],
      ),
    );
  }
}
