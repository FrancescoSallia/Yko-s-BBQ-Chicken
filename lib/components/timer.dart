import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class Timer extends StatelessWidget {
  final int statusIndex;
  const Timer({super.key, required this.statusIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                //das Rechteck vom Timer links Oben
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                    color:
                        statusIndex == 0
                            ? AppColors.timerPrimary
                            : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(600),
                    ),
                  ),
                ),

                //Status Text
                Positioned(
                  bottom: 0,
                  right: 2,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            OrderStatusEnum.recieved.labelText,
                            style: GoogleFonts.inter(
                              fontWeight:
                                  statusIndex == 0
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Lottie.asset(
                      animate: statusIndex == 0 ? true : false,
                      'assets/animations/entry_order.json',
                      repeat: true,
                    ),
                  ),
                ),
              ],
            ),

            //Right Corner
            Stack(
              alignment: Alignment.center,
              children: [
                //das Rechteck vom Timer rechts oben
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                    color:
                        statusIndex == 1
                            ? AppColors.timerPrimary
                            : Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(600),
                    ),
                  ),
                ),
                //Status Text
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            OrderStatusEnum.inProgress.labelText,
                            style: GoogleFonts.inter(
                              fontWeight:
                                  statusIndex == 1
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  child: SizedBox(
                    width: 110,
                    height: 110,
                    child: Lottie.asset(
                      animate: statusIndex == 1 ? true : false,
                      'assets/animations/prepare_food.json',
                      repeat: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 10), // Abstand zu den Rows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                //das Rechteck vom Timer
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                    color:
                        statusIndex == 3
                            ? AppColors.timerPrimary
                            : Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(600),
                    ),
                  ),
                ),
                //Status Text
                Positioned(
                  left: 80,
                  bottom: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            OrderStatusEnum.delivered.labelText,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight:
                                  statusIndex == 3
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 25,
                  top: 0,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Lottie.asset(
                      animate: statusIndex == 3 ? true : false,
                      'assets/animations/delivered.json',
                      repeat: true,
                    ),
                  ),
                ),
              ],
            ),

            //Right Corner Bottom
            Stack(
              alignment: Alignment.center,
              children: [
                //das Rechteck vom Timer
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                    color:
                        statusIndex == 2
                            ? AppColors.timerPrimary
                            : Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(600),
                    ),
                  ),
                ),
                //Status Text
                Positioned(
                  right: 42,
                  bottom: 28,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            OrderStatusEnum.onWay.labelText,
                            style: GoogleFonts.inter(
                              fontWeight:
                                  statusIndex == 2
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 20,
                  child: SizedBox(
                    width: 110,
                    height: 110,
                    child: Lottie.asset(
                      animate: statusIndex == 2 ? true : false,
                      'assets/animations/delivery_riding.json',
                      repeat: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
