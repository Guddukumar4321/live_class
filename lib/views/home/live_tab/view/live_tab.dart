import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/home/live_tab/view/calling_page.dart';
import 'package:live_classroom/widgets/custom_input_field.dart';

import '../../../../core/images/image_path.dart';
import '../../../../services/shared_prefs.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_images.dart';
import '../bloc/live_bloc.dart';
import '../bloc/live_event.dart';
import '../bloc/live_state.dart';


class LiveScreen extends StatefulWidget {

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final TextEditingController _controller = TextEditingController();

  String userId = "122";
  String userName = "UserName";

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      userId = await SharedPrefs.getUserData("uid", false);
      userName = await SharedPrefs.getUserData("name", false);
      setState(() {

      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Live",),
      body: SafeArea(child: Center(child:
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<LiveBloc, LiveState>(

            builder: (context, state) {


               if (state is LiveAvailable) {
                return Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImage(
                      path:Images.videoCall,
                      width: 140,
                      height: 140,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => CallPage(callID: state.callId, userId: userId, userName: userName,),
                        ));
                      },
                      child: Text("Join ${state.hostName}'s Live"),
                    ),
                  ],
                );
              }
               return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   CustomImage(
                     path:Images.videoCall,
                     width: 140,
                     height: 140,
                   ),
                   const SizedBox(height: 20),
                   CustomInputField(controller: _controller, label: "Enter Call ID", icon: Icons.call),
                   ElevatedButton(
                     onPressed: () {
                       context.read<LiveBloc>().add(GoLiveEvent(_controller.text, userId, userName));
                       Navigator.push(context, MaterialPageRoute(
                         builder: (_) => CallPage(callID: _controller.text, userId: userId, userName: userName,),
                       ));
                       _controller.clear();
                     },
                     child: Text("Go Live"),
                   )
                 ],
               );
            },
          ),
        ),)),
    );
  }
}

