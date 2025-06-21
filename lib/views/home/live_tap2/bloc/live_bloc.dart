import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repository/live_repository.dart';
import 'live_event.dart';
import 'live_state.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  final LiveRepository repository;

  LiveBloc(this.repository) : super(LiveInitial()) {
    on<CheckLiveStatusEvent>(_onCheckLive);
    on<GoLiveEvent>(_onGoLive);
    on<JoinLiveEvent>(_onJoinLive);
    on<EndLiveEvent>(_onEndLive);
  }

  Future<void> _onCheckLive(CheckLiveStatusEvent event, Emitter<LiveState> emit) async {
    emit(LiveLoading());
    try {
      final liveData = await repository.getLiveStatus();
      if (liveData == null || !liveData.isLive) {
        emit(LiveNotActive());
      } else {
        emit(LiveActive(
          meetingId: liveData.meetingId,
          passcode: liveData.passcode,
          hostUid: liveData.hostUid,
        ));
      }
    } catch (e) {
      emit(LiveError("Failed to load status"));
    }
  }

  Future<void> _onGoLive(GoLiveEvent event, Emitter<LiveState> emit) async {
    emit(LiveLoading());
    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      final meetingId = "12345678901";
      final passcode = "abc123";
      await repository.goLive(currentUser.uid, meetingId, passcode);
      emit(LiveActive(meetingId: meetingId, passcode: passcode, hostUid: currentUser.uid));
    } catch (e) {
      emit(LiveError("Failed to start live"));
    }
  }

  Future<void> _onJoinLive(JoinLiveEvent event, Emitter<LiveState> emit) async {
    emit(LiveActive(
      meetingId: event.meetingId,
      passcode: event.passcode,
      hostUid: '',
    ));
  }

  Future<void> _onEndLive(EndLiveEvent event, Emitter<LiveState> emit) async {
    emit(LiveLoading());
    try {
      await repository.endLive();
      emit(LiveNotActive());
    } catch (e) {
      emit(LiveError("Failed to end live"));
    }
  }
}
