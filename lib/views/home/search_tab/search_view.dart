import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/home/search_tab/search_bloc.dart';
import 'package:live_classroom/views/home/search_tab/search_event.dart';
import 'package:live_classroom/views/home/search_tab/search_state.dart';
import 'package:live_classroom/widgets/custom_images.dart';

import '../../../widgets/custom_input_field.dart';
import '../home_tab/vimeo_video_player.dart';

class SearchView extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomInputField(
                controller: searchController,
                label: 'Search videos...',
                icon: Icons.search,
                onChanged: (query) {
                  context.read<SearchBloc>().add(SearchVideosEvent(query));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    if (state.results.isEmpty) {
                      return Center(child: Text('No videos found.'));
                    }
                    return ListView.separated(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final video = state.results[index];
                        return ListTile(
                          leading: Icon(Icons.search),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(video.title??"", maxLines: 2, overflow: TextOverflow.ellipsis,)),
                              SizedBox(width: 10,),
                              CustomImage(path: video.thumbnailUrl??"", isNetwork: true, width: 50, height: 30,   fit: BoxFit.cover,)
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VideoPlayerPage(videoId: video.vimeoId??"", title:video.title??""),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index){
                        return SizedBox(height: 10,);
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
