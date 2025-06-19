import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/video_repository.dart';
import 'video_event.dart';
import 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository repository;

  VideoBloc(this.repository) : super(VideoInitial()) {
    on<LoadVideos>((event, emit) async {
      emit(VideoLoading());
      try {
        final videos = await repository.fetchVideos();
        emit(VideoLoaded(videos));
      } catch (e) {
        emit(VideoError('Failed to load videos'));
      }
    });
  }
}
