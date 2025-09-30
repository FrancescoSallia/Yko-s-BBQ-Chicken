import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/card_item.dart';
import 'package:ykos_bbq_chicken/components/category_item.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _animation = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List _categoryList = [
      CategoryItem(isSelected: false, img: "lib/img/category1.png"),
      CategoryItem(isSelected: false, img: "lib/img/category2.png"),
      CategoryItem(isSelected: false, img: "lib/img/category3.png"),
      CategoryItem(isSelected: false, img: "lib/img/category1.png"),
    ];
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset("lib/img/user.png", height: double.infinity),
          ),
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(
                        "Good Chicken.",
                        style: GoogleFonts.inter(
                          color: AppColors.primaryButton,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Fast Delivery.",
                        style: GoogleFonts.inter(
                          color: AppColors.primaryButton,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categoryList.length,
                itemBuilder: (context, index) {
                  final category = _categoryList[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          bottom: 4,
                          top: 0,
                        ),
                        child: category,
                      ),
                      Text(
                        "Main",
                        style: GoogleFonts.inter(
                          color: AppColors.primaryButton,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 18.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Popular",
                    style: GoogleFonts.inter(
                      color: AppColors.primaryButton,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            CardItem(scaleAnimation: _animation, rotationAnimation: _animation),
          ],
        ),
      ),
    );
  }
}
