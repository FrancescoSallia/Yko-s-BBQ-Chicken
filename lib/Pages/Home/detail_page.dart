import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/components/add_extra_icons.dart';
import 'package:ykos_bbq_chicken/components/add_remove_button.dart';
import 'package:ykos_bbq_chicken/components/my_to_cart_button.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_firestore.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModelMenu = context.read<ViewmodelMenu>();
      final viewModelFirestore = context.read<ViewmodelFirestore>();
      await viewModelFirestore
          .fetchFavorites(); // 🔥 Favoriten aus Firestore laden
      viewModelFirestore.isLiked(widget.item);
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
    final viewModelFirestore = context.watch<ViewmodelFirestore>();

    final size = MediaQuery.of(context).size;

    return PopScope(
      //wenn man zurück navigiert mit wischen z.ß. darauf zugreifen.
      // Wird ausgeführt, wenn der Nutzer zurück navigiert (Button, Swipe, etc.)
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Zustand zurücksetzen, wenn Seite verlassen wird
          viewModelMenu.resetExtras();
          widget.item.extras = [];
          widget.item.note = "";
          widget.item.count = 1;
        }
      },
      child: Scaffold(
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
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryButton,
            ),
            onPressed: () {
              // ✅ auch beim manuellen Back-Button dasselbe Verhalten
              viewModelMenu.resetExtras();
              widget.item.extras = [];
              widget.item.note = "";
              widget.item.count = 1;
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await viewModelFirestore.toggleFavorite(widget.item);
                setState(() {
                  // viewModelMenu.toggleFavorite(widget.item);
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
                    // widget.item.isFavorited?
                    viewModelFirestore.isLiked(widget.item)
                        ? "lib/img/liked.png"
                        : "lib/img/unliked.png",
                    width: 30,
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
                // STACK mit Food und Teller
                SizedBox(
                  height: size.height * 0.38,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Hintergrundfarbe
                      Container(
                        height: size.height * 0.38,
                        color: AppColors.primary,
                      ),

                      // Teller + Food
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
                                width: size.width * 0.65,
                                fit: BoxFit.contain,
                              ),
                              // Food (etwas kleiner)
                              Image.asset(
                                widget.item.imgAsset ?? "lib/img/logo_ykos.png",
                                width: size.width * 0.52,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Weißer Sheet-Bereich
                Container(
                  constraints: BoxConstraints(minHeight: size.height * 0.62),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header: Allergens und Labels
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Allergens
                            if (widget.item.allergens.isNotEmpty)
                              Flexible(
                                child: Wrap(
                                  spacing: 4,
                                  children:
                                      widget.item.allergens.asMap().entries.map(
                                        (entry) {
                                          int idx = entry.key;
                                          String allergen = entry.value;
                                          bool isLastString =
                                              idx ==
                                              widget.item.allergens.length - 1;

                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              allergen,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                ),
                              ),

                            // Labels
                            if (widget.item.labels?.isNotEmpty ?? false)
                              Row(
                                children:
                                    widget.item.labels!.map((label) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Image.asset(label, height: 36),
                                      );
                                    }).toList(),
                              )
                            else
                              Row(
                                children: [
                                  Image.asset(
                                    "lib/img/peper_detail.png",
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Image.asset(
                                    "lib/img/peper_detail.png",
                                    height: 36,
                                  ),
                                ],
                              ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Name und Preis
                        Text(
                          widget.item.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          widget.item.price.toEuroString(),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: AppColors.primaryButton,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Beschreibung
                        Text(
                          widget.item.description,
                          style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Divider vor Extras
                        if (viewModelMenu.currentExtras.isNotEmpty) ...[
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                            height: 1,
                          ),

                          const SizedBox(height: 24),

                          // Extras Header
                          Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: AppColors.primaryButton,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Extra's hinzufügen",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Extras Liste
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: viewModelMenu.currentExtras.length,
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final extra = viewModelMenu.currentExtras[index];
                              return AddExtraIcons(
                                extraItem: extra,
                                item: widget.item,
                              );
                            },
                          ),

                          const SizedBox(height: 32),
                        ],

                        // Buttons am Ende
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              // Anzahl Button
                              Expanded(
                                flex: 2,
                                child: AddRemoveButton(
                                  item: widget.item,
                                  gesture: (p0) {
                                    viewModelMenu.updateMeal(p0);
                                  },
                                ),
                              ),

                              const SizedBox(width: 16),

                              // In den Warenkorb Button
                              Expanded(
                                flex: 3,
                                child: MyToCartButton(
                                  gesture: () {
                                    final existingIndex = viewModelMenu.cartList
                                        .indexWhere((cartItem) {
                                          final sameName =
                                              cartItem.name == widget.item.name;
                                          final sameExtras = _compareExtras(
                                            cartItem.extras,
                                            widget.item.extras,
                                          );
                                          return sameName && sameExtras;
                                        });

                                    if (existingIndex != -1) {
                                      // 🔄 Wenn gleiches Item mit gleichen Extras existiert → Menge aktualisieren
                                      setState(() {
                                        viewModelMenu
                                            .cartList[existingIndex]
                                            .count += widget.item.count;
                                      });
                                    } else {
                                      // ➕ Neues Item in den Warenkorb
                                      viewModelMenu.addToCart(widget.item);
                                    }

                                    // 🧹 Zustand zurücksetzen
                                    setState(() {
                                      widget.item.count = 1;
                                      widget.item.extras = [];
                                      widget.item.note = "";
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
                                  totalPriceWithExtraAndAmount:
                                      widget.item.totalWithExtras
                                          .toEuroString(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Extra Abstand am Ende für besseres Scrolling
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
