import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/Pages/detail_page.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CardItem extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> rotationAnimation;
  final String largeTitle;
  final Function() gesture;
  // final List mealList;
  const CardItem({
    super.key,
    required this.scaleAnimation,
    required this.rotationAnimation,
    required this.largeTitle,
    required this.gesture,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 35, left: 18.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                largeTitle,
                style: GoogleFonts.inter(
                  color: AppColors.primaryButton,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap:
              // () {
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     transitionDuration: Duration(milliseconds: 450),
              //     reverseTransitionDuration: Duration(milliseconds: 450),
              //     pageBuilder:
              //         (context, animation, secondaryAnimation) =>
              //             DetailPage(),
              //     transitionsBuilder: (
              //       context,
              //       animation,
              //       secondaryAnimation,
              //       child,
              //     ) {
              //       const begin = Offset(1.0, 0.0); // von rechts rein
              //       const end = Offset.zero;
              //       final tween = Tween(
              //         begin: begin,
              //         end: end,
              //       ).chain(CurveTween(curve: Curves.easeInOut));
              //       return SlideTransition(
              //         position: animation.drive(tween),
              //         child: child,
              //       );
              //     },
              //   ),
              // );
              gesture,

          child: SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 60.0,
                    left: 20,
                    right: 28,
                  ),
                  child: Stack(
                    clipBehavior:
                        Clip.none, // WICHTIG: erlaubt das "Herausragen" des Tellers
                    children: [
                      Container(
                        height: 230,
                        width: 182,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Jollof Rice with 1/4 Chicken & Plantain",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "15€",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Image.asset("lib/img/peper.png"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 🍕 Das Bild ragt nach oben heraus
                      Positioned(
                        top: -50,
                        left: 20,
                        child: RotationTransition(
                          turns: rotationAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // 🩶 Teller mit weichem Schatten (sieht "schwebend" aus)
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.45,
                                        ), // leichte Transparenz
                                        blurRadius:
                                            10, // wie weich der Schatten ist
                                        spreadRadius:
                                            1, // wie weit er sich ausbreitet
                                        offset: const Offset(
                                          18,
                                          15,
                                        ), // Abstand nach unten (Schattenwurf)
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    "lib/img/plate.png",
                                    width: 130,
                                  ),
                                ),

                                // 🍗 Das Food-Bild leicht darüber
                                Image.asset(
                                  "lib/img/chicken_drumsticks.png",
                                  width: 110,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
