class LiveMeeting {
  final bool isLive;
  final String meetingId;
  final String passcode;
  final String hostUid;

  LiveMeeting({required this.isLive, required this.meetingId, required this.passcode, required this.hostUid});

  factory LiveMeeting.fromMap(Map<String, dynamic> map) {
    return LiveMeeting(
      isLive: map['isLive'] ?? false,
      meetingId: map['meetingId'] ?? '',
      passcode: map['passcode'] ?? '',
      hostUid: map['hostUid'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'isLive': isLive,
    'meetingId': meetingId,
    'passcode': passcode,
    'hostUid': hostUid,
  };
}
