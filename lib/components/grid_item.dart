import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class GridItem extends StatelessWidget {
  final Animation<double> rotateAnimation;
  final Animation<double> scaleAnimation;
  const GridItem({
    super.key,
    required this.rotateAnimation,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    final itemWidth = (screenWidth / 2) - 16; // Platz für Padding etc.
    final itemHeight = screenHight * 0.9;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final containerHeight = constraints.maxHeight;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -containerHeight * 0.12, // 12% ragt raus (proportional!)
                  left: 0,
                  right: 0,
                  // bottom: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      RotationTransition(
                        turns: rotateAnimation,
                        child: ScaleTransition(
                          scale: scaleAnimation,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6,
                                  color: Colors.black.withValues(alpha: 0.4),
                                  offset: Offset(15, 10),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "lib/img/plate.png",
                                  height:
                                      containerHeight * 0.48, // proportional
                                ),
                                Image.asset(
                                  "lib/img/food2.png",
                                  height: containerHeight * 0.40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 150),
                            child: Text(
                              "Jollof Rice with 1/4 Chicken & Plantain",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          "15€",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //Unlike Function Todo
                              },
                              child: Image.asset("lib/img/liked.png"),
                            ),

                            IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.shopping_cart),
                            ),
                            // Image.asset("lib/img/peper.png"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
