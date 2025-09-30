import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/my_to_cart_button.dart';
import 'package:ykos_bbq_chicken/components/order_item.dart';
import 'package:ykos_bbq_chicken/components/summary_box.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        title: Text("Cart", style: GoogleFonts.inter(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 3),
            child: Image.asset("lib/img/user.png"),
          ),
        ],
      ),
      drawer: Drawer(),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: 9 + 1,
        itemBuilder: (context, index) {
          if (index < 9) {
            return OrderItem();
          } else {
            return Column(children: [SummaryBox(), SizedBox(height: 110)]);
          }
        },
      ),
    );
  }
}
