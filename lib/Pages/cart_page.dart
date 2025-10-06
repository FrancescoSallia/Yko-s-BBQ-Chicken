import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/checkout_page.dart';
import 'package:ykos_bbq_chicken/components/order_item.dart';
import 'package:ykos_bbq_chicken/components/summary_box.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModelMenu = context.read<ViewmodelMenu>();
      viewModelMenu.loadCartList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();
    final cartItems = viewModelMenu.cartList;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child:
            cartItems.isEmpty
                // 🛒 Wenn leer
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "No Orders in Cart yet 🛒",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                )
                // ✅ Wenn nicht leer
                : SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    child: Column(
                      children: [
                        // 🔹 Alle OrderItems anzeigen
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final order = cartItems[index];
                            return OrderItem(orderItem: order);
                          },
                        ),

                        const SizedBox(height: 20),

                        // 🔹 Danach die SummaryBox anzeigen lassen
                        SummaryBox(),

                        const SizedBox(height: 20),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              // hier Bestellung abschicken oder Warenkorb leeren
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CheckoutPage(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                248,
                                186,
                                0,
                              ),
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Checkout",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.delivery_dining_outlined,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
