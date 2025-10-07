import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class DeliveryTimeContainer extends StatelessWidget {
  final int index;
  final String title;
  final String subTitle;
  final bool isSelected;
  final Function() gesture;
  const DeliveryTimeContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isSelected,
    required this.gesture,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gesture,
      child: Container(
        width: 350,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color:
                isSelected == true
                    ? AppColors.timerTextPrimary
                    : AppColors.textFieldColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isSelected == true ? Icons.check_circle : Icons.circle_outlined,
              size: 28,
              color:
                  isSelected == true
                      ? AppColors.timerTextPrimary
                      : AppColors.textFieldColor,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                Text(
                  subTitle,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textFieldColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
