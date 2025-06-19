import 'package:flutter/material.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../utilites/text_style.dart';
import '../../../widgets/bg_widget.dart';
import '../login/login_view.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool agreedToTerms = false;
  bool loading = false;

  void _registerUser() {
    if (!_formKey.currentState!.validate() || !agreedToTerms) return;

    setState(() => loading = true);

    // TODO: Add Firebase Auth logic here
    Future.delayed(const Duration(seconds: 2), () {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(
       useSafeArea: false,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text("Create Account",
                          style: AppTextStyles.heading2.copyWith(
                              color: AppColors.primary)),
                      const SizedBox(height: 16),
                      _buildInputField(
                        controller: fullNameController,
                        label: 'Full Name',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      _buildInputField(
                        controller: confirmPasswordController,
                        label: 'Confirm Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        validator: (value) => value != passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: agreedToTerms,
                            onChanged: (val) =>
                                setState(() => agreedToTerms = val!),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => agreedToTerms = !agreedToTerms),
                              child: Text(
                                "I agree to the Terms & Conditions",
                                style: AppTextStyles.label,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, AppRoutes.login);

                          },
                          // onPressed: agreedToTerms && !loading
                          //     ? _registerUser
                          //     : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: loading
                              ? const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)
                              : const Text("Sign Up"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: (){},
                        child: const Text("Already have an account? Log in"),
                      ),
                    ],
                  ),
                ),
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
    String? Function(String?)? validator,
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
      validator: validator ??
              (value) => value == null || value.isEmpty
              ? 'Please enter $label'
              : null,
    );
  }
}
