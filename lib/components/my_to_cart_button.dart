import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class MyToCartButton extends StatelessWidget {
  const MyToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.primaryButton,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryButton.withValues(alpha: 0.2),
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add to Cart",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "15€",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
