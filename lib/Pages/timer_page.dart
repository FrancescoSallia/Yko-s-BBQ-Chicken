import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/timer.dart';
import 'package:ykos_bbq_chicken/model/order.dart';
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
            Timer(
              statusIndex: 3,
            ), //TODO: hier muss je nachdem welchen status die bestellung hat der index gewechselt werden!
            //Ankunft Zeit Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ankunft:",
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "ca. 20:45 - 21:10 Uhr",
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
              itemCount: _orderedList.length,
              itemBuilder: (context, index) {
                final orderedItem = _orderedList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(orderedItem.keys.toString()),
                      Text(orderedItem.values.toString()),
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
