import 'package:fixora/core/theme/app_color.dart';
import 'package:flutter/material.dart';

void showTermsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return const _LegalSheetContent(
        title: 'Terms & Conditions',
        body:
            '''Welcome to FIXORA. By creating an account, you agree to the following terms:

1. Service Use
FIXORA connects customers with independent home service technicians (electricians, plumbers, AC technicians, carpenters, and others). We do not employ these technicians directly.

2. Bookings
When you book a service, you agree to be present at the scheduled time and location. Cancellations should be made at least 2 hours in advance.

3. Payments
Prices shown for each service are estimates. The final price may vary based on the actual work required, and will be confirmed with you before the job starts.

4. User Responsibilities
You agree to provide accurate information when booking and to treat technicians with respect and safety.

5. Account
You are responsible for keeping your account credentials secure. FIXORA is not liable for unauthorized access resulting from shared credentials.

6. Changes
We may update these terms from time to time. Continued use of the app means you accept the updated terms.

If you have questions about these terms, contact us through the app.''',
      );
    },
  );
}

void showPrivacySheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return const _LegalSheetContent(
        title: 'Privacy Policy',
        body:
            '''Your privacy matters to us. This policy explains what information FIXORA collects and how it is used.

1. Information We Collect
- Your name, email, and phone number when you register
- Your address, used only to connect you with nearby technicians
- Booking history and service ratings you submit

2. How We Use Your Information
- To match you with available technicians
- To send booking confirmations and updates
- To improve our services based on usage patterns

3. Sharing Your Information
We share your name, phone number, and address with the technician assigned to your booking, so they can complete the service. We do not sell your data to third parties.

4. Data Security
We take reasonable measures to protect your information, but no system is completely secure.

5. Your Rights
You can request to view, update, or delete your account information at any time through the app settings.

6. Contact
If you have questions about how your data is handled, contact us through the app.''',
      );
    },
  );
}

class _LegalSheetContent extends StatelessWidget {
  final String title;
  final String body;

  const _LegalSheetContent({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
