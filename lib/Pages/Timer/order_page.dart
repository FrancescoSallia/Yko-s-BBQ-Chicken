import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/Timer/timer_page.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/repository/time_repository.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final timeRepo = TimeRepository();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModelMenu = context.read<ViewmodelMenu>();
      await viewModelMenu.loadOrdersList();

      if (!mounted) return;
      if (viewModelMenu.error != null) {
        AnimatedSnackBar.material(
          viewModelMenu.error.toString(),
          type: AnimatedSnackBarType.error,
        ).show(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModelMenu.error != null) {
        AnimatedSnackBar.material(
          viewModelMenu.error.toString(),
          type: AnimatedSnackBarType.error,
        ).show(context);
        viewModelMenu.clearError();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Alle Bestellungen wirklich löschen?"),
                    content: Text(
                      "Alle Bestellungen werden gelöscht und kann nicht mehr rückgängig gemacht werden.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          for (var order in viewModelMenu.orderList) {
                            await viewModelMenu.deleteOrderFromList(order);
                          }
                          if (!mounted) return;

                          navigator.pop();
                        },
                        child: Text(
                          "Ja, Löschen",
                          style: GoogleFonts.inter(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Abbrechen",
                          style: GoogleFonts.inter(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              "Liste leeren",
              style: GoogleFonts.inter(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        title: Text(
          "Alle Bestellungen",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body:
          viewModelMenu.orderList.isEmpty
              // 🚚 Wenn leer
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 220,
                      width: 220,
                      child: Opacity(
                        opacity: 0.8,
                        child: Image.asset(
                          "lib/img/lebensmittellieferservice.png",
                        ),
                      ),
                    ),
                    Text(
                      "(Keine Bestellungen)",
                      style: GoogleFonts.inter(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: viewModelMenu.orderList.length,
                      itemBuilder: (context, index) {
                        final order = viewModelMenu.orderList[index];
                        return GestureDetector(
                          onTap:
                              () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => TimerPage(order: order),
                                ),
                              ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 90,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Lottie.asset(
                                      animate: true,
                                      order.orderStatus.lottieAnimation,
                                      repeat:
                                          order.orderStatus ==
                                                  OrderStatusEnum.delivered
                                              ? false
                                              : true,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 240,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.isDelivery
                                            ? "Lieferung"
                                            : "Abholung",
                                        style: GoogleFonts.inter(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Bestellt: "),

                                          timeRepo.dateDayMonthYearToString(
                                            order.currentDate,
                                          ),
                                          SizedBox(width: 10),
                                          timeRepo.timeToString(
                                            order.currentTime,
                                            context,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        order.isDelivery
                                            ? order.deliveryAdress!.name
                                            : "${order.pickUpUser!.name} ${order.pickUpUser!.lastName}",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      Text(
                                        !order.isDelivery &&
                                                order.orderStatus.labelText ==
                                                    OrderStatusEnum
                                                        .delivered
                                                        .labelText
                                            ? OrderStatusEnum.ready.labelText
                                            : order.orderStatus.labelText,

                                        style: GoogleFonts.inter(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Icon(Icons.arrow_forward_ios_rounded, size: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
    );
  }
}
