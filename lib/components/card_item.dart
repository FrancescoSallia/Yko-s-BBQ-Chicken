import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CardItem extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> rotationAnimation;
  final String largeTitle;
  final List<Food> menuList;
  final Function(Food) onItemTap;
  // final List mealList;
  const CardItem({
    super.key,
    required this.scaleAnimation,
    required this.rotationAnimation,
    required this.largeTitle,
    required this.onItemTap,
    required this.menuList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 18.0, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                largeTitle,
                style: GoogleFonts.inter(
                  color: AppColors.primaryButton,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              final menuItem = menuList[index];
              return GestureDetector(
                onTap: () => onItemTap(menuItem),

                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 38.0,
                    left: 20,
                    right: 10,
                    bottom: 8,
                  ),
                  child: Stack(
                    clipBehavior:
                        Clip.none, // WICHTIG: erlaubt das "Herausragen" des Tellers
                    children: [
                      Container(
                        // height: 230,
                        width: 145,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black.withValues(alpha: 0.3),
                              offset: Offset(2, 3),
                            ),
                          ],
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
                                  menuItem.name,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    menuItem.price.toEuroString(),
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children:
                                        (menuItem.labels?.isNotEmpty ?? false)
                                            ? menuItem.labels!
                                                .map(
                                                  (label) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          right: 6.0,
                                                        ),
                                                    child: Image.asset(
                                                      label,
                                                      width: 30,
                                                    ),
                                                  ),
                                                )
                                                .toList()
                                            : [],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 🍕 Das Bild ragt nach oben heraus
                      Positioned(
                        top: -36,
                        left: 23,
                        child: RotationTransition(
                          turns: rotationAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: SizedBox(
                              width: 100, // Größe des gesamten Stack
                              height: 100,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Plate bleibt immer zentriert
                                  Image.asset(
                                    "lib/img/plate.png",
                                    width: 100,
                                    height: 100,
                                  ),

                                  // Food-Bild wird darüber gelegt
                                  Align(
                                    alignment: Alignment.center, // oben mittig
                                    child: Image.asset(
                                      menuItem.imgAsset ??
                                          "lib/img/logo_ykos.png",
                                      width: 80,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
