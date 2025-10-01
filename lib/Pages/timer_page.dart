import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ykos_bbq_chicken/components/timer.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bestellung:",
                  style: GoogleFonts.inter(
                    color: Colors.deepOrangeAccent,
                    fontSize: 24,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "#245444",
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 24),
                ),
              ],
            ),
          ),
          Timer(),

          //Lottie-Gif-Animaton
        ],
      ),
    );
  }
}
