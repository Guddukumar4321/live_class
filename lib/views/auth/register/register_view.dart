import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../utils/text_style.dart';
import '../../../widgets/bg_widget.dart';
import '../../../widgets/custom_input_field.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(
        useSafeArea: false,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },

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
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Create Account",
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          controller: fullNameController,
                          label: 'Full Name',
                          icon: Icons.person,
                          validator: (value) =>
                              value!.isEmpty ? 'Enter name' : null,
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.contains('@') ? null : 'Enter valid email',
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          controller: passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                          validator: (value) =>
                              value!.length < 6 ? 'Too short' : null,
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
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
                            BlocBuilder<AuthBloc, AuthState>(builder: (context, state){
                              return  Checkbox(
                                value: agreedToTerms,
                                onChanged: (val) =>
                                    setState(() => agreedToTerms = val ?? false),
                              );
                            }),

                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(
                                  () => agreedToTerms = !agreedToTerms,
                                ),
                                child: Text(
                                  "I agree to the Terms & Conditions",
                                  style: AppTextStyles.label,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() && agreedToTerms) {
                                    context.read<AuthBloc>().add(
                                      AuthRegisterRequested(
                                        fullName: fullNameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: state is AuthLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : const Text("Sign Up", style: AppTextStyles.button,),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.login);

                          },
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
      ),
    );
  }
}
