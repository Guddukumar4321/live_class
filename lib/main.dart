import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_classroom/views/auth/login/bloc/login_bloc.dart';
import 'package:live_classroom/views/auth/login/repository/login_repository.dart';
import 'package:live_classroom/views/auth/register/bloc/register_bloc.dart';
import 'package:live_classroom/views/auth/register/repository/auth_repository.dart';
import 'core/route/app_pages.dart';
import 'core/route/app_routes.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(LoginRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'LiveClassroom',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routes: AppPages.routes,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}

