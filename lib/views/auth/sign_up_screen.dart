import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:sk_live_vice_group_chat/views/home/base_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? username;
  String? email;
  String? password;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("SignInUp"),
      ),
      body: Form(
        key: key,
        child: ListView(
          padding: EdgeInsets.all(12),
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              validator: ValidationBuilder().maxLength(10).build(),
              onChanged: (value) {
                username = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
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
                    UserCredential usercred = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email!, password: password!);
                    var data = {
                      'username': username,
                      'email': email,
                      'created_at': DateTime.now()
                    };
                    if (usercred.user != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(usercred.user!.uid)
                          .set(data);
                    }
                    if (mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BaseScreen()));
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
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
                    "SignUp",
                    style: TextStyle(color: Colors.white),
                  ))),
            ),
            Text('data')
          ],
        ),
      ),
    );
  }
}
