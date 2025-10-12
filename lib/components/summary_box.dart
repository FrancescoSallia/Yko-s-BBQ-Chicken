import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/model/order_summary.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class SummaryBox extends StatelessWidget {
  final OrderSummary orderSummary;

  const SummaryBox({super.key, required this.orderSummary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 300,
                child: Text(
                  "You have 30% Discount on all meals between August 1st and August 30th, 2022 ",
                  style: GoogleFonts.inter(
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary.withValues(alpha: 0.3),
            border: Border.all(width: 1, color: AppColors.primaryButton),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sub-Total", style: GoogleFonts.inter(fontSize: 14)),
                  Text(
                    "${orderSummary.basisPreis.toStringAsFixed(2)}€",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Charge",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                  Text(
                    "${orderSummary.deliveryCharge.toStringAsFixed(2)}€",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              if (orderSummary.discount != null) ...[
                SizedBox(height: 10),
                Visibility(
                  visible:
                      orderSummary.discount != null ||
                              orderSummary.discount! > 0.0
                          ? true
                          : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount (${(orderSummary.discount! * 100).toStringAsFixed(0)}%)",
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                      Text(
                        "- ${orderSummary.rabattBetrag.toStringAsFixed(2)}€",
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Speisen MwSt. (7%)",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                  Text(
                    "${orderSummary.essenMwst.toStringAsFixed(2)}€",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Getränke MwSt. (19%)",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                  Text(
                    "${orderSummary.getraenkeMwst.toStringAsFixed(2)}€",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${orderSummary.endSummeMitMwSt.toStringAsFixed(2)}€",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
