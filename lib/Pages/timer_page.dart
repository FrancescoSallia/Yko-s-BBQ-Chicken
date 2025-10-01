import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bestellung:",
                style: GoogleFonts.inter(color: Colors.deepOrangeAccent),
              ),
              SizedBox(width: 10),
              Text("#245444"),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  //das Rechteck vom Timer
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      color: AppColors.timerPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(600),
                      ),
                    ),
                  ),

                  //Status Text
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Bestellung ist bei uns Eingegangen",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Lottie.asset(
                        animate: true,
                        'assets/animations/entry_order.json',
                        repeat: true,
                      ),
                    ),
                  ),
                ],
              ),

              //Right Corner
              Stack(
                alignment: Alignment.center,
                children: [
                  //das Rechteck vom Timer
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(600),
                      ),
                    ),
                  ),
                  //Status Text
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Wird Zubereitet",
                              style: GoogleFonts.inter(
                                // fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Lottie.asset(
                        animate: true,
                        'assets/animations/prepare_food.json',
                        repeat: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10), // Abstand zu den Rows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  //das Rechteck vom Timer
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(600),
                      ),
                    ),
                  ),

                  //Status Text
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Geliefert",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Lottie.asset(
                        animate: true,
                        'assets/animations/delivered.json',
                        repeat: true,
                      ),
                    ),
                  ),
                ],
              ),

              //Right Corner
              Stack(
                alignment: Alignment.center,
                children: [
                  //das Rechteck vom Timer
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(600),
                      ),
                    ),
                  ),
                  //Status Text
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Auf dem Weg",
                              style: GoogleFonts.inter(
                                // fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Lottie.asset(
                        animate: true,
                        'assets/animations/delivery_riding.json',
                        repeat: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          //Lottie-Gif-Animaton
        ],
      ),
    );
  }
}
