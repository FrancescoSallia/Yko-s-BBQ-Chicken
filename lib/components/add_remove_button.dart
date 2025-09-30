import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class AddRemoveButton extends StatelessWidget {
  const AddRemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryButton,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryButton.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove, color: AppColors.primaryButton),
          ),
          Text(
            "1",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryButton,
              fontSize: 16,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add, color: AppColors.primaryButton),
          ),
        ],
      ),
    );
  }
}
