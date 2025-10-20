import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/model/order.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';
import 'package:ykos_bbq_chicken/Pages/Timer/order_page.dart';
import 'package:logger/logger.dart';

class OrderPendingPage extends StatefulWidget {
  final Order newOrder;
  const OrderPendingPage({super.key, required this.newOrder});

  @override
  State<OrderPendingPage> createState() => _OrderPendingPageState();
}

class _OrderPendingPageState extends State<OrderPendingPage>
    with TickerProviderStateMixin {
  bool _navigated = false;
  bool _showSuccessAnimation =
      false; // 🔹 Steuert, welche Animation gezeigt wird
  var logger = Logger();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModelMenu = context.read<ViewmodelMenu>();
      if (viewModelMenu.error != null) {
        AnimatedSnackBar.material(
          viewModelMenu.error.toString(),
          type: AnimatedSnackBarType.error,
        ).show(context);
        viewModelMenu.clearError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();

    final order = viewModelMenu.orderList.firstWhere(
      (o) => o.orderId == widget.newOrder.orderId,
      orElse: () => widget.newOrder,
    );

    // 🔹 Wenn die Bestellung bestätigt ist, Erfolg-Animation zeigen
    if (order.confirmedByKitchen && !_showSuccessAnimation) {
      setState(() {
        _showSuccessAnimation = true;
      });

      // Navigation nach der Dauer der Lottie Animation verzögern
      Future.delayed(const Duration(seconds: 3), () {
        if (!_navigated && mounted) {
          _navigated = true;
          Navigator.of(
            context,
          ).pushReplacement(CupertinoPageRoute(builder: (_) => OrderPage()));
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
            _showSuccessAnimation
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/animationSuccessfull.json',
                      repeat: false,
                      onLoaded: (composition) {
                        // Optional: Navigation genau nach Ende der Animation
                        Future.delayed(composition.duration, () {
                          if (!_navigated && mounted) {
                            _navigated = true;
                            Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(builder: (_) => OrderPage()),
                            );
                          }
                        });
                      },
                    ),
                    Text(
                      "Deine Bestellung wurde Bestätigt",
                      textAlign: TextAlign.center, // 🔹 Text zentrieren
                      softWrap: true,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/food_loading.json',
                      repeat: true,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Warte auf Bestätigung deiner Bestellung...",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(),
                  ],
                ),
      ),
    );
  }
}
