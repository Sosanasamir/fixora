import 'package:fixora/core/theme/app_color.dart';
import 'package:fixora/features/auth/ui/login_screen.dart';
import 'package:fixora/features/onboarding/data/onboarding_data.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onboardingList.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                final page = onboardingList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        page.image,
                        height: 400,
                        width: 400,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 20),
                      Text(
                        page.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        page.desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                onboardingList.length,
                (index) => AnimatedContainer(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  duration: Duration(milliseconds: 300),
                  width: currentPage == index ? 12 : 8,
                  height: currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  TextButton(
                    onPressed: () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  SizedBox(width: 80),
                TextButton(
                  onPressed: () {
                    if (currentPage < onboardingList.length - 1) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    currentPage == onboardingList.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 25),
        ],
      ),
    );
  }
}
