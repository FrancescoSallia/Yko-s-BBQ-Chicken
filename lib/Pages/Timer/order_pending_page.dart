import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _OrderPendingPageState extends State<OrderPendingPage> {
  bool _navigated = false; // Verhindert mehrfaches Navigieren
  var logger = Logger();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModelMenu = context.read<ViewmodelMenu>();
      if (viewModelMenu.error != null) {
        AnimatedSnackBar.material(
          viewModelMenu.error.toString(),
          type: AnimatedSnackBarType.error,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Consumer<ViewmodelMenu>(
          builder: (context, viewModel, _) {
            // 🔹 Hole die aktuellste Version der Bestellung
            final order = viewModel.orderList.firstWhere(
              (o) => o.orderId == widget.newOrder.orderId,
              orElse: () => widget.newOrder,
            );

            // 🔹 Navigation nur einmal ausführen, wenn bestätigt
            if (order.confirmedByKitchen && !_navigated) {
              _navigated = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                logger.d("mounted: ${mounted.toString()}");
                if (mounted) {
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (_) => OrderPage()),
                  );
                }
              });
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/animations/food_loading.json',
                  repeat: true,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Warte auf Bestätigung deiner Bestellung...",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
