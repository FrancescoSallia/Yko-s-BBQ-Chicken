import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class FavoritedPage extends StatefulWidget {
  const FavoritedPage({super.key});

  @override
  State<FavoritedPage> createState() => _FavoritedPageState();
}

class _FavoritedPageState extends State<FavoritedPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _animation = Tween(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Favorite",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset("lib/img/user.png", height: double.infinity),
          ),
        ],
      ),
      drawer: Drawer(),
      body: GridView.builder(
        padding: EdgeInsets.only(top: 40, bottom: 120),
        itemCount: 7,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 30,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final screenWidth = MediaQuery.of(context).size.width;
          final itemWidth = (screenWidth / 2) - 16; // Platz für Padding etc.
          final itemHeight = itemWidth * 1.3; // Höhe proportional zur Breite

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
                        top:
                            -containerHeight *
                            0.12, // 12% ragt raus (proportional!)
                        left: 0,
                        right: 0,
                        // bottom: 0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            RotationTransition(
                              turns: _animation,
                              child: ScaleTransition(
                                scale: _animation,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 6,
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
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
                                            containerHeight *
                                            0.53, // proportional
                                      ),
                                      Image.asset(
                                        "lib/img/food1.png",
                                        height: containerHeight * 0.45,
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
                            bottom: 5,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 150),
                                  child: Text(
                                    "Jollof Rice with 1/4 Chicken & Plantain dfibdsifbdsbfds",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
