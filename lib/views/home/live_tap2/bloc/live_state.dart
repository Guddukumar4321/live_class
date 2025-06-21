abstract class LiveState {}

class LiveInitial extends LiveState {}

class LiveLoading extends LiveState {}

class LiveNotActive extends LiveState {}

class LiveActive extends LiveState {
  final String meetingId;
  final String passcode;
  final String hostUid;

  LiveActive({required this.meetingId, required this.passcode, required this.hostUid});
}

class LiveError extends LiveState {
  final String message;
  LiveError(this.message);
}
