import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/detail_page.dart';
import 'package:ykos_bbq_chicken/components/card_item.dart';
import 'package:ykos_bbq_chicken/components/category_item.dart';
import 'package:ykos_bbq_chicken/enum/category_enum.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModelMenu = context.read<ViewmodelMenu>();
      viewModelMenu.getCategoriesFromFoods(viewModelMenu.menuList);
      viewModelMenu.loadMenuFromCategory(CategoryEnum.recommend.label);
    });

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
    final viewModelMenu = context.watch<ViewmodelMenu>();

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

            //Category-List
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    viewModelMenu
                        .getCategoriesFromFoods(viewModelMenu.menuList)
                        .length,
                itemBuilder: (context, index) {
                  final category =
                      viewModelMenu.getCategoriesFromFoods(
                        viewModelMenu.menuList,
                      )[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = index;
                          });

                          // Load the selected Category !
                          viewModelMenu.loadMenuFromCategory(category.name);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            bottom: 4,
                            top: 0,
                          ),
                          child: CategoryItem(
                            isSelected: selectedCategoryIndex == index,
                            img: category.categoryImg,
                            categoryTitle: category.name,
                          ),
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
              largeTitle: 'Recommended',

              menuList: viewModelMenu.menuList,
              onItemTap: (selectedItem) {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => DetailPage(item: selectedItem),
                  ),
                );
              },
            ),
            SizedBox(height: 26),

            ListView.builder(
              itemCount: viewModelMenu.filteredList.length,
              shrinkWrap:
                  true, // <- Passt die Höhe an den Inhalt an und gibt nicht den typischen ´Fehler zurück von wegen mit SingleScrollview geht es nicht !s
              physics:
                  NeverScrollableScrollPhysics(), // <- verhindert doppeltes Scrollen
              itemBuilder: (context, index) {
                final filteredItem = viewModelMenu.filteredList[index];
                return Padding(
                  //TODO:  heir weiter machen um zur detailpage zu navigieren!
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: AppColors.primaryButton.withValues(alpha: 0.9),
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child:
                                  filteredItem.category.name !=
                                          CategoryEnum.drinks.label
                                      ? Image.asset("lib/img/plate.png")
                                      : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black.withValues(
                                              alpha: 0.6,
                                            ),
                                          ),
                                        ),
                                      ),
                            ),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                filteredItem.imgAsset ??
                                    "lib/img/logo_ykos.png",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                '${filteredItem.name} ',
                                style: GoogleFonts.inter(
                                  color: AppColors.primaryButton,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: true,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    filteredItem.price.toEuroString(),
                                    style: GoogleFonts.inter(
                                      color: AppColors.primaryButton,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
