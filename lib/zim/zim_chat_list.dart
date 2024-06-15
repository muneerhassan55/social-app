import 'package:flutter/material.dart';
import 'package:sk_live_vice_group_chat/zim/zim_audio_call.dart';
import 'package:sk_live_vice_group_chat/zim/zim_video_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ZimChatList extends StatelessWidget {
  const ZimChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Conversations'),
          actions: [],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ZIMKit().showDefaultNewPeerChatDialog(context);
          },
          child: Icon(Icons.add),
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                  appBarActions: [
                    IconButton(
                        onPressed: () {
                          String id = conversation.id.toString() +
                              ZIMKit()
                                  .currentUser()!
                                  .baseInfo
                                  .userID
                                  .toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ZimAudioCall(
                                      callId: id, userId: conversation.id)));
                        },
                        icon: Icon(Icons.call)),
                    IconButton(
                        onPressed: () {
                          String id = conversation.id.toString() +
                              ZIMKit()
                                  .currentUser()!
                                  .baseInfo
                                  .userID
                                  .toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ZimVideoCall(
                                      callId: id, userId: conversation.id)));
                        },
                        icon: Icon(Icons.videocam))
                  ],
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
