import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/add_remove_button.dart';
import 'package:ykos_bbq_chicken/components/my_to_cart_button.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<double> _likedAnimation;
  late AnimationController _likedController;
  late AnimationController _scaleController;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();

    //Scale & Rotatation Animaiton
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _scaleAnimation = Tween(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

    //Liked Animation & Controller
    _likedController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _likedAnimation = Tween(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _likedController, curve: Curves.easeOut));

    _scaleController.forward();
    _likedController.reverse();

    _likedController.value = 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    _scaleController.dispose();
    _likedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Food Details",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton.filled(
          style: IconButton.styleFrom(backgroundColor: AppColors.primaryButton),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isLiked = !_isLiked;
                _likedController.reset();
                _likedController.forward().then((value) {
                  _likedController.reverse();
                });
              });
            },
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(right: 20, top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: ScaleTransition(
                scale: _likedAnimation,
                child: Image.asset(
                  _isLiked ? "lib/img/liked.png" : "lib/img/unliked.png",
                ),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Spacer(),

            RotationTransition(
              turns: _scaleAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 280, // Teller größer
                      height: 280,
                      child: Transform.scale(
                        scale: 2.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(400),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 8,
                                spreadRadius: -60,
                                offset: Offset(5, 6),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset("lib/img/plate.png", width: 150),
                              Image.asset(
                                "lib/img/pizza_angela1.png",
                                width: 120,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 300, // Essen kleiner
                    //   // height: 200,
                    //   child: Image.asset("lib/img/food1.png", width: 100),
                    // ),
                  ],
                ),
              ),
            ),

            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                  bottom: 50,
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Image.asset("lib/img/peper_detail.png")],
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Jollof Rice with 1/4 Chicken & Plantain",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Image(image: AssetImage("lib/img/rating.png")),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 91, 91, 91),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [AddRemoveButton(), MyToCartButton()],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
