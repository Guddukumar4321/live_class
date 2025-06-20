import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/home/home_tab/bloc/video_event.dart';
import 'package:live_classroom/views/home/home_tab/bloc/video_state.dart';

import '../repository/video_repository.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;

  VideoBloc(this.videoRepository) : super(VideoInitial()) {
    on<LoadVideos>((event, emit) async {
      emit(VideoLoading());
      try {
        final videos = await videoRepository.fetchVideos();
        emit(VideoLoaded(videos));
      } catch (e) {
        emit(VideoError('Failed to load videos'));
      }
    });
  }
}
