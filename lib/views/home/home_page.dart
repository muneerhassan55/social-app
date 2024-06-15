import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sk_live_vice_group_chat/views/home/search.dart';
import 'package:sk_live_vice_group_chat/views/home/utils/post_text.dart';

import '../auth/sign_in _screen.dart';
import 'utils/imagepost.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController postText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        title: const Text(
          "Home Screen",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              },
              leading: Icon(Icons.logout),
              title: Text("Sign Out"),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.indigo)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: postText,
                        decoration:
                            InputDecoration(labelText: 'Post something'),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Post'),
                      onPressed: () {
                        var data = {
                          'time': DateTime.now(),
                          'type': 'text',
                          'content': postText.text,
                          'uid': FirebaseAuth.instance.currentUser!.uid
                        };

                        FirebaseFirestore.instance
                            .collection('posts')
                            .add(data);
                        postText.text = "";
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('timeline')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data?.docs.isEmpty ?? true) {
                          return Text('No Post for yours');
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data?.docs.length ?? 0,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc((snapshot.data?.docs[index].data()
                                            as Map)['post'])
                                        .get(),
                                    builder: (context, postsnapshot) {
                                      if (postsnapshot.hasData) {
                                        switch (postsnapshot.data!['type']) {
                                          case 'text':
                                            return PostTextScreen(
                                                text: postsnapshot
                                                    .data!['content']);
                                          case 'image':
                                            return ImaagePostScreen(
                                              text:
                                                  postsnapshot.data!['content'],
                                              url: postsnapshot.data!['url'],
                                            );

                                          default:
                                            return PostTextScreen(
                                                text:
                                                    postsnapshot.data!['type']);
                                        }
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    });
                              });
                        }
                      } else {
                        return LinearProgressIndicator();
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
