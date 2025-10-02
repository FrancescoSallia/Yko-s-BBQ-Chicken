import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/Pages/sheet_note_page.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chicken and Chips",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "15€",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.6,
                          child: SheetNotePage(),
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary.withValues(
                      alpha: 0.1,
                    ), // 🔹 Hintergrundfarbe
                    foregroundColor:
                        AppColors.primaryButton, // 🔹 Text/Icon-Farbe
                    side: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ), // 🔹 Rahmen
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.edit_note_rounded, size: 18),
                      SizedBox(width: 5),
                      Text("Notiz"),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.remove),
                      iconSize: 16,
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.primaryButton.withValues(
                          alpha: 0.2,
                        ),
                        foregroundColor: AppColors.primaryButton,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "1",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      iconSize: 16,
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primaryButton,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),

            Divider(color: Colors.black, thickness: 2.2, height: 20),
          ],
        ),
      ],
    );
  }
}
