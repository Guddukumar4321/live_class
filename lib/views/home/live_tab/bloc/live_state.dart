abstract class LiveState {}

class LiveInitial extends LiveState {}

class NoOneLive extends LiveState {}

class LiveAvailable extends LiveState {
  final String hostName;
  final String callId;

  LiveAvailable({required this.hostName, required this.callId});
}

class LiveStartedByUser extends LiveState {
  final String callId;

  LiveStartedByUser(this.callId);
}

class LiveEnded extends LiveState {}

class LiveError extends LiveState {
  final String message;

  LiveError(this.message);
}
