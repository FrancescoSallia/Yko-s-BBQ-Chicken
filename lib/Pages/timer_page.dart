import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/order_item.dart';
import 'package:ykos_bbq_chicken/components/summary_box.dart';
import 'package:ykos_bbq_chicken/components/timer.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/order.dart';
import 'package:ykos_bbq_chicken/repository/time_repository.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:flutter_dash/flutter_dash.dart';

class TimerPage extends StatelessWidget {
  final Order order;
  const TimerPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final timeRepo = TimeRepository();
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bestellung:",
                    style: GoogleFonts.inter(
                      color: AppColors.timerTextPrimary,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "#${order.orderId.substring(0, 10)}",
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 24),
                  ),
                ],
              ),
            ),
            Timer(statusIndex: order.orderStatus.statusIndex),
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
                            : "ca 40- 50 min"
                        : "${timeRepo.dateDayMonthYearToString(order.selectedDate).data} - ca. ${timeRepo.timeToString(order.selectedTime, context).data}",
                    style: GoogleFonts.inter(
                      color: AppColors.timerTextPrimary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.orderSummary.foods.length,
              itemBuilder: (context, index) {
                final orderedItem = order.orderSummary.foods[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Text(
                                "${orderedItem.count.toString()}x",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                orderedItem.name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            orderedItem.price.toEuroString(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderedItem.extras?.length ?? 0,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final extra = orderedItem.extras?[index];
                          if (extra == null) return null;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0,
                                    ),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        Text("+ ${extra.name}"),
                                        Text("${extra.anzahl.toString()}x"),
                                      ],
                                    ),
                                  ),
                                  Text(extra.price.toEuroString()),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                          top: 5,
                        ),
                        child: Text(
                          orderedItem.note!.isNotEmpty
                              ? "↳ ${orderedItem.note}"
                              : "(leer)",
                          style: GoogleFonts.inter(
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                          ),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 15),
                      Dash(
                        length: MediaQuery.of(context).size.width - 40,
                        dashLength: 15,
                        dashColor: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),

            SummaryBox(orderSummary: order.orderSummary),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
