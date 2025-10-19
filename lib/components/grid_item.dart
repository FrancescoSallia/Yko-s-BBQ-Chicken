import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class GridItem extends StatefulWidget {
  final Animation<double> rotateAnimation;
  final Animation<double> scaleAnimation;
  final Food favoritedItem;
  final Function() toggleFavoriteGesture;
  const GridItem({
    super.key,
    required this.rotateAnimation,
    required this.scaleAnimation,
    required this.favoritedItem,
    required this.toggleFavoriteGesture,
  });

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ViewmodelMenu>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();

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
                        turns: widget.rotateAnimation,
                        child: ScaleTransition(
                          scale: widget.scaleAnimation,
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
                                  widget.favoritedItem.imgAsset ??
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
                              widget.favoritedItem.name,
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
                          widget.favoritedItem.price.toEuroString(),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: widget.toggleFavoriteGesture,
                              child: Image.asset(
                                "lib/img/liked.png",
                                width: 32,
                              ),
                            ),

                            IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                // setState(() {
                                //   final favoritedItem = widget.favoritedItem;

                                //   //Bug Fixxed- immer ne neue copy vom Object erstellen und das hinufügen, entfernen oder updaten
                                //   viewModelMenu.addToCart(favoritedItem);
                                // });

                                final existingIndex = viewModelMenu.cartList
                                    .indexWhere((cartItem) {
                                      final sameName =
                                          cartItem.name ==
                                          widget.favoritedItem.name;
                                      final sameExtras = _compareExtras(
                                        cartItem.extras,
                                        widget.favoritedItem.extras,
                                      );
                                      return sameName && sameExtras;
                                    });

                                if (existingIndex != -1) {
                                  // 🔄 Wenn gleiches Item mit gleichen Extras existiert → Menge aktualisieren
                                  setState(() {
                                    viewModelMenu
                                        .cartList[existingIndex]
                                        .count += widget.favoritedItem.count;
                                  });
                                } else {
                                  // ➕ Neues Item in den Warenkorb
                                  viewModelMenu.addToCart(widget.favoritedItem);
                                }

                                // 🧹 Zustand zurücksetzen
                                setState(() {
                                  widget.favoritedItem.count = 1;
                                  widget.favoritedItem.extras = [];
                                  widget.favoritedItem.note = "";
                                  for (var extra
                                      in viewModelMenu.currentExtras) {
                                    extra.anzahl = 0;
                                  }
                                });
                                AnimatedSnackBar.material(
                                  "Zur Bestellung hinzugefügt",
                                  type: AnimatedSnackBarType.success,
                                ).show(context);
                              },
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

bool _compareExtras(List<Extra>? extras1, List<Extra>? extras2) {
  if (extras1 != null && extras2 != null) {
    if (extras1.length != extras2.length) return false;
    for (final extra in extras1) {
      final match = extras2.any(
        (e) =>
            e.name == extra.name &&
            e.price == extra.price &&
            e.anzahl == extra.anzahl,
      );
      if (!match) return false;
    }
  }
  return true;
}
