/*
// live_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/live_repository.dart';
import 'live_event.dart';
import 'live_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  final LiveRepository repo;
  LiveBloc(this.repo) : super(LiveInitial()) {
    on<CheckLiveStatus>(_onCheck);
    on<GoLive>(_onGo);
    on<JoinLive>(_onJoin);
    on<EndLive>(_onEnd);
  }

  Future _onCheck(event, emit) async {
    emit(LiveLoading());
    try {
      final live = await repo.getLiveSession();
      if (live == null) return emit(LiveNotAvailable());

      final uid = FirebaseAuth.instance.currentUser!.uid;
      if (live.hostUid == uid) {
        emit(LiveHostView(live.meetingId, live.token));
      } else {
        emit(LiveJoinView(live.meetingId, live.token));
      }
    } catch (e) {
      emit(LiveError(e.toString()));
    }
  }

  Future _onGo(event, emit) async {
    emit(LiveLoading());
    try {
      final live = await repo.createLiveSession();
      emit(LiveHostView(live.meetingId, live.token));
    } catch (e) {
      emit(LiveError(e.toString()));
    }
  }

  Future _onJoin(event, emit) async {
    emit(LiveLoading());
    final live = await repo.getLiveSession();
    if (live == null) return emit(LiveError('No live session'));
    emit(LiveJoinView(live.meetingId, live.token));
  }

  Future _onEnd(event, emit) async {
    await repo.endLiveSession();
    emit(LiveNotAvailable());
  }
}
*/
