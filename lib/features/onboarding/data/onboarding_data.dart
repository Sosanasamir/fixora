class OnboardingData {
  final String image;
  final String title;
  final String desc;

  OnboardingData({
    required this.title,
    required this.image,
    required this.desc,
  });
}

final onboardingList = [
  OnboardingData(
    title: 'Book a technician in one tap',
    image: 'assets/images/onboarding1.png',
    desc:
        'Electrician, plumber, AC technician, or carpenter, all home services in one place',
  ),
  OnboardingData(
    title: 'Trusted technicians, real reviews',
    image: 'assets/images/onboarding2.png',
    desc:
        'Every technician is verified and rated by real customers, book with confidence',
  ),
  OnboardingData(
    title: 'Track your order every step',
    image: 'assets/images/onboarding3.png',
    desc: 'From booking to arrival to job done, follow it all in real time',
  ),
];
