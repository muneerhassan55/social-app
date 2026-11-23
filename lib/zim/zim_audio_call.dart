import 'package:sk_live_vice_group_chat/zego_config.dart';
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
        appID: zegoAppId,
        appSign: zegoAppSign,
        callID: widget.callId,
        userID: widget.userId,
        userName: "User : ${widget.userId}",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
