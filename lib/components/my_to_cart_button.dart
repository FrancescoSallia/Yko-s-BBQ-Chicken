import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class MyToCartButton extends StatelessWidget {
  final Function() gesture;
  final String totalPriceWithExtraAndAmount;
  const MyToCartButton({
    super.key,
    required this.gesture,
    required this.totalPriceWithExtraAndAmount,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        backgroundColor: AppColors.primaryButton,
        foregroundColor: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      onPressed: gesture,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add to Cart",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 10),
            Text(
              totalPriceWithExtraAndAmount,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
