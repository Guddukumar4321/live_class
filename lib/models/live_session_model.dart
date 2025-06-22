class LiveSessionModel {
  final String hostUid;
  final String hostName;
  final String callId;

  LiveSessionModel({required this.hostUid, required this.hostName, required this.callId});

  factory LiveSessionModel.fromMap(Map<String, dynamic> map) {
    return LiveSessionModel(
      hostUid: map['host_uid'],
      hostName: map['host_name'],
      callId: map['call_id'],
    );
  }
}
