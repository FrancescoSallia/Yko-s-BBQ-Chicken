import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class GridItem extends StatelessWidget {
  final Animation<double> rotateAnimation;
  final Animation<double> scaleAnimation;
  final Food favoritedItem;
  final Function() toggleFavoriteGesture;
  const GridItem({
    super.key,
    required this.rotateAnimation,
    required this.scaleAnimation,
    required this.favoritedItem, required this.toggleFavoriteGesture,
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
                                      containerHeight * 0.40, // proportional
                                ),
                                Image.asset(
                                  favoritedItem.imgAsset ??
                                      "lib/img/logo_ykos.png",
                                  height: containerHeight * 0.32,
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
                          padding: const EdgeInsets.only(left: 8, bottom: 8.0),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 150),
                            child: Text(
                              favoritedItem.name,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          favoritedItem.price % 1 == 0
                              ? "${favoritedItem.price.toInt()}"
                              : "${favoritedItem.price.toStringAsFixed(2).replaceAll(".", ",")} €",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: toggleFavoriteGesture,
                              child: Image.asset(
                                "lib/img/liked.png",
                                width: 32,
                              ),
                            ),

                            IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.shopping_cart, size: 20),
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
