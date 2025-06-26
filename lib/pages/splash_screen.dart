import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zomato_user/main.dart';
import 'package:zomato_user/pages/home_page.dart';

import '../auth_page/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // navigateToNextScreen Method call
    navigateToNextScreen();
    super.initState();
  }

  navigateToNextScreen() async {
    // In SharedPreferences check(Get) user data, Before user login or not
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? data = sf.getString("userId") ?? "";

    print(data);
    print(globalDocId);
    print("____________________________________");

    Future.delayed(Duration(seconds: 3), () {
      //Before user login, Then if condition otherwise else
      if (data != "") {
        globalDocId = data;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "zomato",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 110, left: 110),
              child: Divider(),
            ),
            Text(
              "AN ETERNAL COMPANY",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
