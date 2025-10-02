import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class AddExtraIcons extends StatelessWidget {
  const AddExtraIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Extra Brokkoli",
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton.filled(
              style: IconButton.styleFrom(
                iconSize: 12,
                backgroundColor: AppColors.primaryButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                minimumSize: const Size(18, 18),
              ),
              onPressed: () {},
              icon: Icon(Icons.remove),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text("1"),
            ),
            IconButton.filled(
              style: IconButton.styleFrom(
                iconSize: 12,
                backgroundColor: AppColors.timerPrimary2,
                foregroundColor: AppColors.primaryButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                minimumSize: const Size(18, 18),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
