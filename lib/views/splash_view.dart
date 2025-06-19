import 'package:flutter/material.dart';
import 'dart:async';

import '../core/images/image_path.dart';
import '../core/route/app_routes.dart';
import '../utilites/text_style.dart';
import '../widgets/bg_widget.dart';
import '../widgets/custom_images.dart';
import 'auth/register/register_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      // Navigate to Register Page
      Navigator.pushReplacementNamed(context, AppRoutes.register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(
        useSafeArea: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(
                path:Images.logo,
                width: 140,
                height: 140,
              ),
              const SizedBox(height: 20),
              Text(
                'LiveClassroom',
                style: AppTextStyles.heading2,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
