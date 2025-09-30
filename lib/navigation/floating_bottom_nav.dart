import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:ykos_bbq_chicken/Pages/cart_page.dart';
import 'package:ykos_bbq_chicken/Pages/home_page.dart';
import 'package:ykos_bbq_chicken/Pages/favorited_page.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class FloatingBottomNav extends StatefulWidget {
  const FloatingBottomNav({super.key});

  @override
  State<FloatingBottomNav> createState() => _FloatingBottomNavState();
}

class _FloatingBottomNavState extends State<FloatingBottomNav> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    FavoritedPage(),
    Center(child: Text("👤 Profile Page")),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      barColor:
          Colors
              .transparent, //Hintergrundfarbe vom Kasten der BottomNav (Die Box vom Außen)
      width: double.infinity, // die breite des bottomNav
      duration: Duration(
        milliseconds: 700,
      ), // wie lange die animation andauern soll
      curve: Curves.decelerate, // die animation beim erscheinen des bottomNav
      body: (context, controller) => pages[currentIndex],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40, bottom: 8, top: 8),
          decoration: BoxDecoration(
            color: Colors.black, // hintergrundfarbe von der bottomNav
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 1, color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                Icons.home_filled,
                0,
              ), //BottomNav items die angezeigt werden sollen mit dem jeweiligen icon und index der navigation Liste
              _buildNavItem(
                currentIndex == 1 ? Icons.favorite : Icons.favorite_border,
                1,
              ),
              _buildNavItem(Icons.search, 2),
              _buildNavItem(Icons.shopping_cart_outlined, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey,
            size: 26,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(top: 4),
            height: 3,
            width: isSelected ? 20 : 0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
