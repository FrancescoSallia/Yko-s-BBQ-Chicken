import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
    final viewModelMenu = context.read<ViewmodelMenu>();
    viewModelMenu.loadOrdersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Order's",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: viewModelMenu.orderList.length,
            itemBuilder: (context, index) {
              final order = viewModelMenu.orderList[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.deliveryAdress?.name ?? ""),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            timeRepo.dateDayMonthYearToString(
                              order.currentDate,
                            ),
                            SizedBox(width: 10),
                            timeRepo.timeToString(order.currentTime, context),
                          ],
                        ),
                        Text(
                          "Bestellungsstatus: z.ß In Arbeit",
                          style: GoogleFonts.inter(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          order.isDelivery ? "Lieferung" : "Abholung",
                          style: GoogleFonts.inter(
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(order.orderId),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
