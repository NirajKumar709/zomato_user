import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zomato_user/auth_page/sign_in_page.dart';

import '../main.dart';

class Registration extends StatefulWidget {
  final String docId;

  const Registration({super.key, required this.docId});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  userRegistrationStore({
    required String name,
    required String address,
    required String phoneNumber,
  }) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("users_profile")
        .doc(widget.docId)
        .set({
          "name": name,
          "address": address,
          "phoneNumber": phoneNumber,
          "imageURL": storeURL,
        })
        .then((value) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Registration Successfully")));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        });
  }

  File? imagePath;

  imageUpload() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath = File(image.path);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Not select image")));
    }

    setState(() {});
  }

  String storeURL = "";

  imageURLStore() async {
    if (imagePath != null) {
      final storageRef = FirebaseStorage.instance.ref();

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final childRef = storageRef.child(
        "user_profile/${widget.docId}$fileName.jpg",
      );

      await childRef.putFile(imagePath!);

      storeURL = await childRef.getDownloadURL();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Image not upload")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Registration",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "address",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  imageUpload();
                },
                child: Text("Upload your image"),
              ),
              SizedBox(
                height: 100,
                child:
                    imagePath != null
                        ? Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 90,
                              color: Colors.red,
                              child: Image.file(imagePath!, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 0,
                              left: 50,
                              child: IconButton(
                                onPressed: () {
                                  imagePath = null;

                                  setState(() {});
                                },
                                icon: Icon(Icons.close, size: 30),
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        )
                        : Text("No Image selected"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await imageURLStore();
                  userRegistrationStore(
                    name: nameController.text,
                    address: addressController.text,
                    phoneNumber: phoneController.text,
                  );
                },
                child: Text("Register Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
