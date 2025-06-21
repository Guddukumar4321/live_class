
class LiveSessionModel {
  final bool isLive;
  final String hostUid;
  final String meetingId;
  final String token;
  final DateTime? createdAt;

  LiveSessionModel({
    required this.isLive,
    required this.hostUid,
    required this.meetingId,
    required this.token,
    this.createdAt,
  });

  factory LiveSessionModel.fromMap(Map<String, dynamic> map) {
    return LiveSessionModel(
      isLive: map['isLive'] ?? false,
      hostUid: map['hostUid'] ?? '',
      meetingId: map['meetingId'] ?? '',
      token: map['token'] ?? '',
      createdAt:  null, //map['createdAt'] != null ? (map['createdAt'] as Timestamp).toDate() :
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLive': isLive,
      'hostUid': hostUid,
      'meetingId': meetingId,
      'token': token,
      'createdAt': createdAt,
    };
  }
}
