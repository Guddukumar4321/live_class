import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class BgWidget extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;

  const BgWidget({
    Key? key,
    required this.child,
    this.useSafeArea = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(child: child),
    );

    return useSafeArea ? SafeArea(child: content) : content;
  }
}
