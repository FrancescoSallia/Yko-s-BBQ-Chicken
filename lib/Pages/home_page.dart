import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/Pages/detail_page.dart';
import 'package:ykos_bbq_chicken/components/card_item.dart';
import 'package:ykos_bbq_chicken/components/category_item.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/repository/food_repository.dart';
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
      CategoryItem(
        isSelected: false,
        img: "lib/img/category1.png",
        categoryTitle: 'Main',
      ),
      CategoryItem(
        isSelected: false,
        img: "lib/img/category2.png",
        categoryTitle: 'Menu',
      ),
      CategoryItem(
        isSelected: false,
        img: "lib/img/category3.png",
        categoryTitle: 'Drinks',
      ),
      CategoryItem(
        isSelected: false,
        img: "lib/img/category1.png",
        categoryTitle: 'MeatMeatMeatMeatMeatMeat',
      ),
    ];

    //TODO: Mach hier weiter ! gib es in den listbuilder aus
    final foodRepo = FoodRepository();

    var foodList = foodRepo.getFoodsOrDrinks();

    List<String> getCategoriesFromFoods(final List<Food> foods) {
      List<String> categories = [];

      for (var food in foods) {
        if (!categories.contains(food.category)) {
          categories.add(food.category);
        }
      }
      return categories;
    }

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 3),
            child: Image.asset("lib/img/user.png"),
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 18,
              ),
              child: CupertinoSearchTextField(),
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
                    ],
                  );
                },
              ),
            ),

            CardItem(
              scaleAnimation: _animation,
              rotationAnimation: _animation,
              largeTitle: 'Recommended',
              gesture: () {
                Navigator.of(
                  context,
                ).push(CupertinoPageRoute(builder: (context) => DetailPage()));
              },
            ),

            ListView.builder(
              itemCount: 5,
              shrinkWrap:
                  true, // <- Passt die Höhe an den Inhalt an und gibt nicht den typischen ´Fehler zurück von wegen mit SingleScrollview geht es nicht !s
              physics:
                  NeverScrollableScrollPhysics(), // <- verhindert doppeltes Scrollen
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gericht ${index + 1}',
                          style: GoogleFonts.inter(
                            color: AppColors.primaryButton,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryButton,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}
