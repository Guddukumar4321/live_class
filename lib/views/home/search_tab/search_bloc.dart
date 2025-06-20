import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/home/search_tab/search_event.dart';
import 'package:live_classroom/views/home/search_tab/search_state.dart';

import '../../../models/video_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FirebaseFirestore firestore;

  SearchBloc(this.firestore) : super(SearchInitial()) {
    on<SearchVideosEvent>(_onSearch);
  }

  Future<void> _onSearch(SearchVideosEvent event, Emitter<SearchState> emit) async {
    try {
      emit(SearchLoading());

      final snapshot = await firestore.collection('videos').get();

      final results = snapshot.docs
          .map((doc) => VideoModel.fromJson(doc.data()))
          .where((video) => (video.title??"").toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError('Failed to search videos.'));
    }
  }
}
