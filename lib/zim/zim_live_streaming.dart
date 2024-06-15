import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class liveStrem extends StatefulWidget {
  const liveStrem({super.key});

  @override
  State<liveStrem> createState() => _liveStremState();
}

class _liveStremState extends State<liveStrem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Stream'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ZegoLiveStrem(
                      uid: '111111', liveId: '123123', username: 'Start')));
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.indigo),
              height: 40,
              width: 180,
              child: Center(
                  child: Text(
                'Start Live Strem',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ZegoLiveStrem(
                      uid: '121212', liveId: '123123', username: 'maria')));
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.indigo),
              height: 40,
              width: 180,
              child: Center(
                  child: Text(
                'Join Live Strem',
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
    ;
  }
}

class ZegoLiveStrem extends StatefulWidget {
  final String uid, username, liveId;
  ZegoLiveStrem(
      {super.key,
      required this.uid,
      required this.liveId,
      required this.username});

  @override
  State<ZegoLiveStrem> createState() => _ZegoLiveStremState();
}

class _ZegoLiveStremState extends State<ZegoLiveStrem> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltLiveStreaming(
        appID: 1279593144,
        appSign:
            'b69e38f37724d6bad7c031612419b8881edabc206a445d29a17e626f0426b547',
        userID: widget.uid,
        userName: widget.username,
        liveID: widget.liveId,
        config: widget.uid == "111111"
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience());
  }
}
