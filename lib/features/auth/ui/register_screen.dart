import 'package:fixora/core/theme/app_color.dart';
import 'package:fixora/core/widgets/app_button.dart';
import 'package:fixora/core/widgets/app_text_field.dart';
import 'package:fixora/features/auth/cubit/auth_cubit.dart';
import 'package:fixora/features/auth/cubit/auth_state.dart';
import 'package:fixora/features/auth/ui/login_screen.dart';
import 'package:fixora/features/auth/ui/widgets/legal_sheets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool agreedTerms = false;
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/register.png',
                  height: 250,
                  width: 250,
                  fit: BoxFit.contain,
                ),
                Text(
                  'Create account',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Book trusted technician fast',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 24),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        label: 'Name',
                        hint: 'enter your name',
                        controller: name,
                        icon: Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      AppTextField(
                        label: 'Email',
                        hint: 'name@example.com',
                        controller: email,
                        icon: Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      AppTextField(
                        label: 'Phone Number',
                        hint: '01xxxxxxxxx',
                        controller: phone,
                        icon: Icon(Icons.phone),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your phone number';
                          }
                          if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                            return 'please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      AppTextField(
                        label: 'Password',
                        hint: '',
                        controller: password,
                        icon: Icon(Icons.lock),
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your password';
                          }
                          if (value.length < 6) {
                            return 'password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      AppTextField(
                        label: 'Confirm Password',
                        hint: '',
                        controller: confirmPassword,
                        icon: Icon(Icons.lock),
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please onfirm your password';
                          }
                          if (value != password.text) {
                            return 'passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(
                            value: agreedTerms,
                            onChanged: (value) {
                              setState(() {
                                agreedTerms = value ?? false;
                              });
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                const TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms',
                                  style: TextStyle(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showTermsSheet(context);
                                    },
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showPrivacySheet(context);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      AppButton(
                        isLoading: isLoading,
                        title: 'Create account',
                        colour: AppColors.primary,
                        onPressed: () {
                          if (!agreedTerms) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'you must agree terms and privacy',
                                ),
                              ),
                            );
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              name.text,
                              email.text,
                              password.text,
                              phone.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            const TextSpan(text: 'Already have an account?'),
                            TextSpan(
                              text: ' Log in',
                              style: TextStyle(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
