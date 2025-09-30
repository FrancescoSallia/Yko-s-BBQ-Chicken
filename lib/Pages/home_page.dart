import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/Pages/detail_page.dart';
import 'package:ykos_bbq_chicken/components/card_item.dart';
import 'package:ykos_bbq_chicken/components/category_item.dart';
import 'package:ykos_bbq_chicken/components/grid_item.dart';
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
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _animation = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController
        .stop(); // Wenn du zu schnell die Pages hin und her wechselst kommt es zu einem Fehler im Compiler -> erst stoppen dann disposen und anschließend die super.dispose(), genau diese Reihenfolge!
    _animationController.dispose();
    super.dispose();
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
        surfaceTintColor: Colors.transparent,
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

            CardItem(
              scaleAnimation: _animation,
              rotationAnimation: _animation,
              largeTitle: 'Popular',
              gesture: () {
                Navigator.of(
                  context,
                ).push(CupertinoPageRoute(builder: (context) => DetailPage()));
              },
            ),
            CardItem(
              scaleAnimation: _animation,
              rotationAnimation: _animation,
              largeTitle: 'Menu',
              gesture: () {},
            ),
            SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}
