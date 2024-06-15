import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sk_live_vice_group_chat/views/auth/sign_in%20_screen.dart';
import 'package:sk_live_vice_group_chat/views/home/chat_list.dart';
import 'package:sk_live_vice_group_chat/views/home/home_page.dart';
import 'package:sk_live_vice_group_chat/views/home/search.dart';
import 'package:sk_live_vice_group_chat/views/home/utils/imagepost.dart';
import 'package:sk_live_vice_group_chat/views/home/utils/post_text.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) {
            setState(() {
              index = i;
            });
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live ')
          ],
        ),
        body: IndexedStack(
          index: index,
          children: [
            HomePage(),
            ChatListScreen(),
            // HomePage(),
            Container()
          ],
        ));
  }
}
