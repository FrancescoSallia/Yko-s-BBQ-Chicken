import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/order_item.dart';
import 'package:ykos_bbq_chicken/components/summary_box.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int lengthList = 5;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              itemCount: lengthList + 1,
              itemBuilder: (context, index) {
                if (index < lengthList) {
                  return OrderItem();
                } else {
                  return Column(
                    children: [
                      SummaryBox(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              248,
                              186,
                              0,
                            ),
                            foregroundColor: Colors.black,
                            minimumSize: Size(double.infinity, 55),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Order Now",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.delivery_dining_outlined, size: 24),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 110),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
