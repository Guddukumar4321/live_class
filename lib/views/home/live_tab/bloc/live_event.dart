abstract class LiveEvent {}

class CheckLiveStatus extends LiveEvent {}

class GoLiveEvent extends LiveEvent {
  final String callId;
  final String userId;
  final String userName;

  GoLiveEvent(this.callId, this.userId, this.userName);
}

class EndLiveEvent extends LiveEvent {}

class JoinLiveEvent extends LiveEvent {}
