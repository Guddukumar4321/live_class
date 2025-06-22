import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/home/home_tab/widgets/video_card.dart';

import '../../../models/video_model.dart';
import '../../../widgets/custom_app_bar.dart';
import 'bloc/video_bloc.dart';
import 'bloc/video_state.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: "Video",),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
      if (state is VideoLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is VideoLoaded) {
          return ListView.builder(
            itemCount: state.videos.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              VideoModel data = state.videos[index];
              return VideoCard(data: data,);
            },
          );
        } else if (state is VideoError) {
        return Center(child: Text(state.message));
      }
      return const SizedBox();
        },
      ),
    );
  }
}
