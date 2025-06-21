/*
// live_state.dart
abstract class LiveState {}
class LiveInitial extends LiveState {}
class LiveLoading extends LiveState {}
class LiveAvailable extends LiveState {
  final String meetingId, token;
  LiveAvailable(this.meetingId, this.token);
}
class LiveJoinView extends LiveState {
  final String meetingId, token;
  LiveJoinView(this.meetingId, this.token);
}
class LiveHostView extends LiveState {
  final String meetingId, token;
  LiveHostView(this.meetingId, this.token);
}
class LiveNotAvailable extends LiveState {}
class LiveError extends LiveState {
  final String message;
  LiveError(this.message);
}
*/
