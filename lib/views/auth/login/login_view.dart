import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/value/String_value.dart';
import '../../../utils/text_style.dart';
import '../../../widgets/bg_widget.dart';
import '../../../widgets/custom_input_field.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;



  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.main);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BgWidget(
          useSafeArea: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Welcome Back",
                          style: AppTextStyles.heading2
                              .copyWith(color: AppColors.primary)),
                      const SizedBox(height: 8),
                      Text("Login to your ${ConstString.appName} account",
                          style: AppTextStyles.bodyLight),
                      const SizedBox(height: 32),
                      CustomInputField(
                        controller: emailController,
                        label: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        controller: passwordController,
                        label: 'Password',
                        suffixIcon: Icon(Icons.check_circle, color: Colors.green),
                        icon: Icons.lock,
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: state is LoginLoading
                                  ? null
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(
                                    LoginRequested(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child:state is LoginLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                                  : Text("Login", style: AppTextStyles.button),
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, AppRoutes.register);
                        },
                        child: const Text("Don't have an account? Sign up"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )

    );
  }


}
