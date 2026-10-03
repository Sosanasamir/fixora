import 'package:fixora/core/theme/app_color.dart';
import 'package:fixora/core/widgets/app_button.dart';
import 'package:fixora/features/auth/cubit/auth_cubit.dart';
import 'package:fixora/features/auth/cubit/auth_state.dart';
import 'package:fixora/features/auth/ui/login_screen.dart';
import 'package:fixora/features/profile/ui/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> account = [
    {'title': 'My address', 'icon': Icons.location_on_outlined},
    {'title': 'Payment Methods', 'icon': Icons.credit_card_outlined},
    {'title': 'Booking History', 'icon': Icons.history},
  ];

  final List<Map<String, dynamic>> preferences = [
    {'title': 'Notifications', 'icon': Icons.notifications_outlined},
    {'title': 'Help and Support', 'icon': Icons.help_outline},
  ];

  @override
  initState() {
    super.initState();
    context.read<AuthCubit>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthError) {
          return Scaffold(
            body: Center(
              child: Text(
                'something went wrong!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          );
        }

        if (state is AuthLoading || state is AuthInitial) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is AuthCurrentUserSuccess) {
          final user = state.user;
          final name = user.name.split(' ');
          final initials = name.length > 1
              ? '${name[0][0]}${name[1][0]}'.toUpperCase()
              : name[0][0].toUpperCase();
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: AppColors.accentLight),
              ),
              iconTheme: IconThemeData(color: AppColors.accentLight),
              elevation: 0,
              backgroundColor: AppColors.primary,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateProfileScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit, color: AppColors.accentLight),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 210,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: 0,
                        right: 0,
                        child: Center(
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
                      ),
                      Positioned(
                        top: 104,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              user.phone,
                              style: TextStyle(color: AppColors.primaryLight),
                            ),
                            SizedBox(height: 4),
                            Text(
                              user.email,
                              style: TextStyle(color: AppColors.primaryLight),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...account.map((item) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    item['icon'],
                                    color: AppColors.primary,
                                  ),
                                  title: Text(
                                    item['title'],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preferences',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            ...preferences.map((item) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    item['icon'],
                                    color: AppColors.primary,
                                  ),
                                  title: Text(
                                    item['title'],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppButton(
                      title: 'Log Out',
                      colour: AppColors.background,
                      textColor: AppColors.error,
                      borderColor: AppColors.error,
                      onPressed: () {
                        context.read<AuthCubit>().logOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
