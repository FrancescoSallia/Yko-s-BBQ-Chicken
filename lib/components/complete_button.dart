import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CompleteButton extends StatelessWidget {
  final String text;
  final Function() gesture;
  const CompleteButton({super.key, required this.text, required this.gesture});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gesture,
      child: Container(
        padding: EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryButton.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryButton,
          ),
        ),
      ),
    );
  }
}
