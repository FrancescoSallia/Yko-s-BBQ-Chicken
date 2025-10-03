import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/Pages/cart_page.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class MyToCartButton extends StatelessWidget {
  const MyToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(CupertinoPageRoute(builder: (context) => CartPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
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
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "15,90€",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
