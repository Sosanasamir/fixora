import 'package:fixora/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class AppOtpField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  const AppOtpField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: controller,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: 40,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 40,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.accent),
        ),
      ),
      onChanged: onChanged,
      onCompleted: onCompleted,
    );
  }
}
