import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/components/add_extra_icons.dart';
import 'package:ykos_bbq_chicken/components/add_remove_button.dart';
import 'package:ykos_bbq_chicken/components/my_to_cart_button.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class DetailPage extends StatefulWidget {
  final Food item;
  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _likedController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _likedAnimation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModelMenu = context.read<ViewmodelMenu>();
      viewModelMenu.loadExtrasForItem(widget.item.category.name);
    });
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = Tween(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

    _likedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _likedAnimation = Tween(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _likedController, curve: Curves.easeOut));

    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _likedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          widget.item.name,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton.filled(
          style: IconButton.styleFrom(backgroundColor: AppColors.primaryButton),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                viewModelMenu.toggleFavorite(widget.item);

                _likedController
                    .forward(from: 0)
                    .then((_) => _likedController.reverse());
              });
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(right: 20, top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: ScaleTransition(
                scale: _likedAnimation,
                child: Image.asset(
                  widget.item.isFavorited
                      ? "lib/img/liked.png"
                      : "lib/img/unliked.png",
                  width: 28,
                ),
              ),
            ),
          ),
        ],
      ),

      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              // STACK mit Pizza und Teller
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Hintergrundfarbe
                  Container(
                    height: size.height * 0.45,
                    color: AppColors.primary,
                  ),

                  // Teller + Pizza
                  RotationTransition(
                    turns: _scaleAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Teller (größer)
                          Image.asset(
                            "lib/img/plate.png",
                            width: MediaQuery.of(context).size.width * 0.65,
                            fit: BoxFit.contain,
                          ),
                          // Pizza (etwas kleiner)
                          Image.asset(
                            widget.item.imgAsset ?? "lib/img/logo_ykos.png",
                            width: MediaQuery.of(context).size.width * 0.52,

                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Weißer Sheet-Bereich (scrollt mit nach oben)
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children:
                                widget.item.allergens.isNotEmpty
                                    ? widget.item.allergens.asMap().entries.map(
                                      //zerteilen es auf einzelne Strings
                                      (entry) {
                                        // holen uns die positionen der jeweiligen Strings in der liste, geben den wert als String weiter und anschließend ein bool um zu überprüfen ob kein komma am ende der liste gehöhren soll.
                                        int idx = entry.key;
                                        String allergen = entry.value;
                                        bool isLastString =
                                            idx ==
                                            widget.item.allergens.length - 1;

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0,
                                          ),
                                          child: Text(
                                            isLastString
                                                ? allergen // falls es der letzte String von der Liste ist soll kein komma sein, ansonsten soll da ein komma hin.
                                                : "$allergen ,",
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()
                                    : [
                                      // Text(
                                      //   "F,A",
                                      //   style: GoogleFonts.inter(
                                      //     fontWeight: FontWeight.w700,
                                      //     fontSize: 12,
                                      //   ),
                                      // ),
                                    ],
                          ),

                          Row(
                            children:
                                (widget.item.labels?.isNotEmpty ?? false)
                                    ? widget.item.labels!.map((label) {
                                      return Image.asset(label, height: 40);
                                    }).toList()
                                    : [
                                      Image.asset(
                                        "lib/img/peper_detail.png",
                                        height: 40,
                                      ),
                                      Image.asset(
                                        "lib/img/peper_detail.png",
                                        height: 40,
                                      ),
                                    ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          widget.item.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          widget.item.price.toEuroString(),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        widget.item.description,
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 91, 91, 91),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "Zutaten",
                      //       style: GoogleFonts.inter(
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 26,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // ListView(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   children: [
                      //     AddExtraIcons(),
                      //     AddExtraIcons(),
                      //     AddExtraIcons(),
                      //     AddExtraIcons(),
                      //     AddExtraIcons(),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      Divider(color: Colors.black, height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20.0,
                              top: 20,
                            ),
                            child: Text(
                              "Extra's",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: viewModelMenu.currentExtras.length,
                        itemBuilder: (context, index) {
                          final extra = viewModelMenu.currentExtras[index];
                          return AddExtraIcons(extraItem: extra);
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AddRemoveButton(
                            item: widget.item,
                            gesture: (p0) {
                              viewModelMenu.updateMeal(p0);
                            },
                          ),
                          MyToCartButton(
                            gesture: () {
                              setState(() {
                                print(widget.item.count);
                                viewModelMenu.addToCart(widget.item);
                                print(widget.item.count);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
