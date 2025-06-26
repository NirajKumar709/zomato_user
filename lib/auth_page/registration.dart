import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zomato_user/auth_page/sign_in_page.dart';

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
        .collection("users")
        .doc(widget.docId)
        .set({"name": name, "address": address, "phoneNumber": phoneNumber})
        .then((value) {
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
}
