import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/Home/detail_page.dart';
import 'package:ykos_bbq_chicken/components/grid_item.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ViewmodelMenu>();
      viewModel.loadFavoritedList();
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _animation = Tween(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ViewmodelMenu>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("lib/img/logo_ykos.png", height: 28),
            SizedBox(width: 10),
            Text(
              "Favorite's",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,

                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(0, 5),
          child: Divider(color: Colors.black),
        ),
      ),
      body:
          viewModel.favoritedList.isNotEmpty
              ? SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 40, bottom: 120),
                      itemCount: viewModel.favoritedList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 55,
                        crossAxisSpacing: 0,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final favoritedItem = viewModel.favoritedList[index];
                        return GestureDetector(
                          onTap:
                              () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder:
                                      (context) =>
                                          DetailPage(item: favoritedItem),
                                ),
                              ),
                          child: GridItem(
                            rotateAnimation: _animation,
                            scaleAnimation: _animation,
                            favoritedItem: favoritedItem,
                            toggleFavoriteGesture: () {
                              viewModel.toggleFavorite(favoritedItem);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
              : Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Favorites yet ",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 25,
                        child: Image.asset("lib/img/logo_ykos.png"),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
