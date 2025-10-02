import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/grid_item.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            Row(
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
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 40, bottom: 120),
              itemCount: 7,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                mainAxisSpacing: 55,
                crossAxisSpacing: 0,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GridItem(
                  rotateAnimation: _animation,
                  scaleAnimation: _animation,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
