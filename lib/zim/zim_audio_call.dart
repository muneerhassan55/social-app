import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZimAudioCall extends StatefulWidget {
  final String callId, userId;
  const ZimAudioCall({super.key, required this.callId, required this.userId});

  @override
  State<ZimAudioCall> createState() => _ZimVideoCallState();
}

class _ZimVideoCallState extends State<ZimAudioCall> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 1279593144,
        appSign:
            'b69e38f37724d6bad7c031612419b8881edabc206a445d29a17e626f0426b547',
        callID: widget.callId,
        userID: widget.userId,
        userName: "User : ${widget.userId}",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
