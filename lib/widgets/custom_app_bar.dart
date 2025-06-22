import 'package:flutter/material.dart';

import '../core/images/image_path.dart';
import '../core/theme/app_theme.dart';
import 'custom_images.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const CustomAppBar({super.key, required this.title, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const SizedBox(width: 12),
          // App icon with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 45,
              width: 45,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColors.black, width: 0.3)
              ),
              child: CustomImage(
                path: Images.infyApp,
                width: 40,
                height: 40,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
