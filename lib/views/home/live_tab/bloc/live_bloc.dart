import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/live_repository.dart';
import 'live_event.dart';
import 'live_state.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  final LiveRepository repo;
  final String currentUserId;

  LiveBloc({required this.repo, required this.currentUserId}) : super(LiveInitial()) {
    on<CheckLiveStatus>(_onCheckLiveStatus);
    on<GoLiveEvent>(_onGoLive);
    on<EndLiveEvent>(_onEndLive);
    on<JoinLiveEvent>(_onJoinLive);
  }

  Future<void> _onCheckLiveStatus(CheckLiveStatus event, Emitter emit) async {
    final session = await repo.getLiveSession();
    if (session == null) {
      emit(NoOneLive());
    } else if (session.hostUid == currentUserId) {
      // emit(LiveStartedByUser(session.callId));
      emit(LiveAvailable(hostName: session.hostName, callId: session.callId));
    } else {
      emit(LiveAvailable(hostName: session.hostName, callId: session.callId));
    }
  }

  Future<void> _onGoLive(GoLiveEvent event, Emitter emit) async {
    await repo.startLive(event.callId, event.userId, event.userName);
    emit(LiveStartedByUser(event.callId));
  }

  Future<void> _onEndLive(EndLiveEvent event, Emitter emit) async {
    await repo.endLive();
    emit(LiveEnded());
  }

  Future<void> _onJoinLive(JoinLiveEvent event, Emitter emit) async {
    final session = await repo.getLiveSession();
    if (session != null) {
      emit(LiveAvailable(hostName: session.hostName, callId: session.callId));
    }
  }
}
