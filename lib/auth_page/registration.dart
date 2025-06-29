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

  String storeURL = "";

  userRegistrationStore({
    required String name,
    required String address,
    required String phoneNumber,
  }) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("users")
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
      body: Padding(
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
            ElevatedButton(
              onPressed: () {
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
    );
  }

  imageUpload() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);

    if (img == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please Select Image")));
    } else {
      final file = File(img.path);

      final storageRef = FirebaseStorage.instance.ref().child(
        "user_image/${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      try {
        await storageRef.putFile(file).then((p0) async {
          final imageUrl = storageRef.getDownloadURL();

          imageURL = await imageUrl;
          storeURL = await imageUrl;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Image Uploaded Successfully")),
          );
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
