import 'package:flutter/material.dart';
import '../../views/auth/login/login_view.dart';
import '../../views/auth/register/register_view.dart';
import '../../views/home/dashboard/main_screen.dart';
import '../../views/splash_view.dart';
import 'app_routes.dart';

class AppPages {

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.splash:      (_) =>  SplashScreen(),
    AppRoutes.login:       (_) =>  LoginPage(),
    AppRoutes.register:    (_) =>  RegisterPage(),
    AppRoutes.main:        (_) =>  MainScreen(),
    // AppRoutes.profile:     (_) => const ProfilePage(),
    // AppRoutes.liveStream:  (_) => const LiveStreamPage(),
    // AppRoutes.videoLibrary:(_) => const VideoLibraryPage(),
    // AppRoutes.search:      (_) => const SearchPage(),
  };

  /// Optional: an [onGenerateRoute] fallback if you prefer.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    // Unknown route → 404 screen or redirect
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Page not found')),
      ),
    );
  }
}
