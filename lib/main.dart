import 'package:flutter/material.dart';
import 'package:zomato_user/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

String globalDocId = "";
String imageURL = "";

String restaurantName = "";
String restaurantItemName = "";
String foodItemImage = "";
String selectedItemCount = "";
String selectedItemPrice = "";
String userName = "";
String userPhoneNumber = "";

String currentAddress = "";
String subLocalityName = "";
String localityName = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false);
  }
}
