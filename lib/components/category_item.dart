import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String img;
  final String categoryTitle;
  const CategoryItem({
    super.key,
    required this.isSelected,
    required this.img,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
        ),
        SizedBox(height: 6),
        Container(
          width: 74,
          child: Center(
            child: Text(
              categoryTitle,
              style: GoogleFonts.inter(
                color: AppColors.primaryButton,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
