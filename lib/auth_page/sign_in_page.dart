import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zomato_user/auth_page/sign_up_page.dart';

import '../main.dart';
import '../pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    if (emailAddress.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All field required")));
      return;
    }
    if (emailAddress.contains("@gmail.com")) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emailAddress, password: password)
            .then((value) async {
              // email's data store in SharedPreferences variable.
              SharedPreferences sf = await SharedPreferences.getInstance();
              sf.setString("userId", value.user!.uid);
              print(value.user!.uid);

              globalDocId = value.user!.uid;

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Login Successfully")));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            });
      }
      // when fill wrong email/password then not showSnackBar message(this doubt clear with amit bro)
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("User doesn't exist")));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Wrong password")));
        }
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter InValid email")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "LogIn",
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
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your email",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Enter your password",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                signInWithEmailAndPassword(
                  emailAddress: emailController.text,
                  password: passwordController.text,
                );
                emailController.clear();
                passwordController.clear();
              },
              child: Text("Sign In"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("I have already account ?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
