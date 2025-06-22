import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../utils/app_info.dart';
import '../repositories/live_repository.dart';

class CallPage extends StatefulWidget {
  final String callID;
  final String userId;
  final String userName;

  CallPage({
    Key? key,
    required this.callID,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}


class _CallPageState extends State<CallPage> {

  @override
  void dispose() {
    callEnd();
    super.dispose();
  }

  Future callEnd() async {
    await LiveRepository().endLive();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Call ended")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
  var callId = widget.callID.trim();

    return ZegoUIKitPrebuiltCall(
      appID: AppInfo.appId,
      appSign: AppInfo.appSing,
      userID: "2435465765",
      userName: widget.userName,
      callID: callId,

      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),

    );
  }
}
