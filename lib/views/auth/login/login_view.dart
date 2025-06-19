import 'package:flutter/material.dart';

import '../../../core/route/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../utilites/text_style.dart';
import '../../../widgets/bg_widget.dart';


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

  void _loginUser() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    // TODO: Add Firebase login logic here
    Future.delayed(const Duration(seconds: 2), () {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BgWidget(
      useSafeArea: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
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
                  Text("Login to your LiveClassroom account",
                      style: AppTextStyles.bodyLight),
                  const SizedBox(height: 32),
                  _buildInputField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: passwordController,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, AppRoutes.main);
                      },
                      // onPressed: !loading ? _loginUser : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: loading
                          ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                          : const Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: (){

                    },
                    child: const Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) => value == null || value.isEmpty
          ? 'Please enter $label'
          : null,
    );
  }
}
