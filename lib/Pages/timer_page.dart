import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/timer.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/order.dart';
import 'package:ykos_bbq_chicken/repository/time_repository.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class TimerPage extends StatelessWidget {
  final Order order;
  const TimerPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _orderedList = [
      {"Pizza Marghertia": "12,50€"},
      {"Pizza Tonno": "11,50€"},
      {"Pizza Vegetale": "10,90€"},
      {"Pizza Salami": "10,90€"},
      {"Pizza Funghi": "10,90€"},
      {"Pizza Funghi": "10,90€"},
      {"Pizza Funghi": "10,90€"},
      {"Pizza Funghi": "10,90€"},
      {"Pizza Funghi": "10,90€"},
      {"Pizza Funghi": "10,90€"},
      {"Pizza Funghi": "10,90€"},
    ];

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
                              Text("${orderedItem.count.toString()}x"),
                              Text(orderedItem.name),
                            ],
                          ),
                          Text(orderedItem.price.toEuroString()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("Extra's"),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderedItem.extras?.length ?? 0,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final extra = orderedItem.extras?[index];
                          if (extra == null) return null;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "+ ${extra.name}",
                                    ), //TODO: Hier weiter machen !!
                                    Text("${extra.anzahl.toString()}x"),
                                  ],
                                ),
                              ),
                              Text(extra.price.toEuroString()),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            // SummaryBox(orderSummary: null,),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
