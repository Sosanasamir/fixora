import 'package:fixora/core/theme/app_color.dart';
import 'package:fixora/core/widgets/app_button.dart';
import 'package:fixora/core/widgets/app_text_field.dart';
import 'package:fixora/features/auth/ui/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/forget_password.png',
              fit: BoxFit.contain,
              width: 250,
              height: 250,
            ),
            Text(
              'Forgot password?',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Enter your email and we\'ll send you a\n link to reset your password',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            Form(
              key: formKey,
              child: AppTextField(
                label: 'Email',
                hint: 'enter your email',
                controller: email,
                icon: Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
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
            ),
            SizedBox(height: 20),
            AppButton(
              title: 'Send Reset Link',
              colour: AppColors.primary,
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                children: [
                  const TextSpan(text: 'Remember your password?'),
                  TextSpan(
                    text: 'Log in',
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
    );
  }
}
