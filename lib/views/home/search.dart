import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Search for a user'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Enter Username'),
            onChanged: (value) {
              username = value;
              setState(() {});
            },
          ),
          if (username != null)
            if (username!.length > 3)
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isEqualTo: username)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.docs.isEmpty ?? false) {
                      return Text('No data Found');
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return ListTile(
                              leading: IconButton(
                                color: Colors.indigo,
                                icon: Icon(Icons.chat),
                                onPressed: () async {
                                  QuerySnapshot q = await FirebaseFirestore
                                      .instance
                                      .collection('chats')
                                      .where('users',
                                          arrayContains: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .get();
                                  if (q.docs.isEmpty) {
                                    print('No Docs');
                                    var data = {
                                      'users': [
                                        FirebaseAuth.instance.currentUser!.uid,
                                        doc.id,
                                      ],
                                      'recent_text': "Hi",
                                    };
                                    await FirebaseFirestore.instance
                                        .collection('chats')
                                        .add(data);
                                  } else {
                                    print('Yes Docs');
                                  }
                                },
                              ),
                              title: Text(doc['username']),
                              trailing: FutureBuilder<DocumentSnapshot>(
                                  future: doc.reference
                                      .collection('followers')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data?.exists ?? false) {
                                        return GestureDetector(
                                          onTap: () async {
                                            await doc.reference
                                                .collection('followers')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .delete();
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.indigo),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Center(
                                                child: Text(
                                                  'Unfollow',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return GestureDetector(
                                        onTap: () async {
                                          await doc.reference
                                              .collection('followers')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                            ..set({'time': DateTime.now()});
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.indigo),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Center(
                                              child: Text(
                                                'Follow',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }));
                        }),
                  );
                },
              )
        ],
      ),
    );
  }
}
