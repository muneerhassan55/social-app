import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final DocumentSnapshot doc;
  ChatPage({super.key, required this.doc});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        title: Text(
          'Chat Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: widget.doc.reference
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.docs.isEmpty ?? true) {
                      return Text('No messaes yet !');
                    }
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (context, index) {
                          DocumentSnapshot msg = snapshot.data!.docs[index];
                          if (msg['uid'] ==
                              FirebaseAuth.instance.currentUser!.uid) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.green.shade200),
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        msg['message'].toString(),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ),
                              ],
                            );
                            //my message
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.indigo.shade100),
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        msg['message'].toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ),
                              ],
                            );
                          }
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Your Message'),
                  controller: messageController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await widget.doc.reference.collection('messages').add({
                    'time': DateTime.now(),
                    'uid': FirebaseAuth.instance.currentUser!.uid,
                    'message': messageController.text
                  });
                  await widget.doc.reference
                      .update({'recent_text': messageController.text});
                  messageController.text = "";
                },
                child: Text("Send"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white // background color
                    ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
