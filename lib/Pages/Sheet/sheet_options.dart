import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class SheetOptions extends StatelessWidget {
  const SheetOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.cancel, color: Colors.black, size: 30),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 0),
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ],
            color: Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Löschen",
                  style: GoogleFonts.inter(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  shadows: [BoxShadow(blurRadius: 10, spreadRadius: 1)],
                  Icons.delete,
                  size: 28,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 0),
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ],
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bearbeiten",
                  style: GoogleFonts.inter(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  shadows: [BoxShadow(blurRadius: 10, spreadRadius: 1)],
                  Icons.edit_square,
                  size: 28,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
