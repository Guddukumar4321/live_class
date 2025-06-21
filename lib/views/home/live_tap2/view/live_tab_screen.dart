import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/live_bloc.dart';
import '../bloc/live_event.dart';
import '../bloc/live_state.dart';

class LiveTabScreen extends StatelessWidget {
  const LiveTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live')),
      body: BlocBuilder<LiveBloc, LiveState>(
        builder: (context, state) {
          if (state is LiveLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LiveNotActive) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<LiveBloc>().add(GoLiveEvent());
                },
                child: Text("Go Live"),
              ),
            );
          } else if (state is LiveActive) {
            final isHost = state.hostUid == FirebaseAuth.instance.currentUser?.uid;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<LiveBloc>().add(GoLiveEvent());

                    },
                    child: Text(isHost ? "Rejoin Live" : "Join Live"),
                  ),
                  if (isHost)
                    TextButton(
                      onPressed: () {
                        context.read<LiveBloc>().add(EndLiveEvent());
                      },
                      child: Text("End Live", style: TextStyle(color: Colors.red)),
                    )
                ],
              ),
            );
          } else if (state is LiveError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
