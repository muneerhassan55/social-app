import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:sk_live_vice_group_chat/views/auth/sign_up_screen.dart';
import 'package:sk_live_vice_group_chat/views/home/base_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  String? email;
  String? password;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Sign In"),
      ),
      body: Form(
        key: key,
        child: ListView(
          padding: EdgeInsets.all(12),
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              validator: ValidationBuilder().email().maxLength(50).build(),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: ValidationBuilder().maxLength(15).build(),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                if (key.currentState?.validate() ?? false) {
                  print(email);
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email!, password: password!);
                    if (mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BaseScreen()));
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'wrong-password:') {
                      print('The password provided is wrong.');
                    }
                    if (e.code == "user-not-found") {
                      print("No user");
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10)),
                  height: 40,
                  child: Center(
                      child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ))),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text("Create an account"),
            )
          ],
        ),
      ),
    );
  }
}
