import 'package:fixora/core/theme/app_color.dart';
import 'package:fixora/core/widgets/app_button.dart';
import 'package:fixora/core/widgets/app_text_field.dart';
import 'package:fixora/features/auth/cubit/auth_cubit.dart';
import 'package:fixora/features/auth/cubit/auth_state.dart';
import 'package:fixora/features/auth/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserModel user;
  const UpdateProfileScreen({super.key, required this.user});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.user.name;
    email.text = widget.user.email;
    phone.text = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to update profile.')),
          );
        }
        if (state is AuthUpdateProfileSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final user = widget.user;
        final nameParts = user.name.trim().split(RegExp(r'\s+'));
        final initials = nameParts.length > 1
            ? '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase()
            : nameParts[0][0].toUpperCase();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.background,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          backgroundColor: AppColors.background,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.accent,
                  child: Text(
                    initials,
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              AppTextField(
                label: 'Full Name',
                hint: 'enter your name',
                controller: name,
                icon: Icon(Icons.edit),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 8),
              AppTextField(
                label: 'Email',
                hint: 'enter your email',
                controller: email,
                icon: Icon(Icons.edit),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8),
              AppTextField(
                label: 'Phone Number',
                hint: '',
                controller: phone,
                icon: Icon(Icons.edit),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text(
                  'change your password?',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButton(
                  title: 'Save Changes',
                  colour: AppColors.accent,
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    context.read<AuthCubit>().updateProfile(
                      name.text,
                      email.text,
                      phone.text,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
