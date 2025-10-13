import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/complete_orders.dart';
import 'package:ykos_bbq_chicken/components/summary_box.dart';
import 'package:ykos_bbq_chicken/components/timer.dart';
import 'package:ykos_bbq_chicken/components/user_information_box.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/model/order.dart';
import 'package:ykos_bbq_chicken/repository/time_repository.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class TimerPage extends StatelessWidget {
  final Order order;
  const TimerPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final timeRepo = TimeRepository();
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Timer",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(preferredSize: Size(0, 5), child: Divider()),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bestellung:",
                    style: GoogleFonts.inter(
                      color: AppColors.timerTextPrimary,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "#${order.orderId.substring(0, 13)}",
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 22),
                  ),
                ],
              ),
            ),
            Timer(
              statusIndex: order.orderStatus.statusIndex,
              isDelivery: order.isDelivery,
            ),
            //Ankunft Zeit Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    order.isDelivery ? "Ankunft:" : "Abholung:",
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Text(
                    order.isDelivery
                        ? order.selectedTime != null ||
                                order.selectedDate != null
                            ? "${timeRepo.dateDayMonthYearToString(order.selectedDate).data} - ca. ${timeRepo.timeToString(order.selectedTime, context).data}"
                            : "ca. 40- 50 min"
                        : "${timeRepo.dateDayMonthYearToString(order.selectedDate).data} - ${timeRepo.timeToString(order.selectedTime, context).data}",
                    style: GoogleFonts.inter(
                      color: AppColors.timerTextPrimary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Text(
                  order.isDelivery ? "Liefer-Information" : "Abholer/in",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            UserInformationBox(order: order),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Text(
                  "Deine Bestellung",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            CompleteOrders(order: order),
            SummaryBox(orderSummary: order.orderSummary),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
