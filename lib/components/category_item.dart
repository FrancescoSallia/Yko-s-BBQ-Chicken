import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String img;
  const CategoryItem({super.key, required this.isSelected, required this.img});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryButton : AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryButton.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          height: 70,
          width: 70,
          child: Center(child: Image.asset(img)),
        ),
      ],
    );
  }
}
