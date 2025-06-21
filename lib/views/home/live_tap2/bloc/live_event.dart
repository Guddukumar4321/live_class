abstract class LiveEvent {}

class CheckLiveStatusEvent extends LiveEvent {}

class GoLiveEvent extends LiveEvent {}

class JoinLiveEvent extends LiveEvent {
  final String meetingId;
  final String passcode;

  JoinLiveEvent({required this.meetingId, required this.passcode});
}

class EndLiveEvent extends LiveEvent {}
