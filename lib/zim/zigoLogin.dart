import 'package:flutter/material.dart';
import 'package:sk_live_vice_group_chat/zim/zim_chat_list.dart';
import 'package:sk_live_vice_group_chat/zim/zim_live_streaming.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ZigoLoginClass extends StatefulWidget {
  const ZigoLoginClass({super.key});

  @override
  State<ZigoLoginClass> createState() => _ZigoKitClassState();
}

class _ZigoKitClassState extends State<ZigoLoginClass> {
  TextEditingController userId = TextEditingController();
  TextEditingController userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Zim Login'),
      ),
      body: ListView(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'User Name'),
            controller: userName,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Usser Id'),
            controller: userId,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.indigo), // Replace Colors.blue with your desired color
            ),
            onPressed: () async {
              await ZIMKit().connectUser(id: userId.text, name: userName.text);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          // ZimChatList()
                          liveStrem())); // Your onPressed function logic
            },
            child: Text('Connect'),
          )
        ],
      ),
    );
  }
}
