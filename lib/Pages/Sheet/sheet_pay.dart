import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/model/payment.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class SheetPay extends StatelessWidget {
  const SheetPay({super.key});

  @override
  Widget build(BuildContext context) {
    List<Payment> payments = [
      Payment(name: "Apple Pay", img: "lib/img/applepay.png"),
      Payment(name: "PayPal", img: "lib/img/paypal.png"),
      Payment(name: "Klarna", img: "lib/img/klarna.png"),
      Payment(name: "Barzahlung", img: "lib/img/applepay.png"),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 12),
          child: Text(
            "Wähle eine Zahlungsmöglichkeit aus",
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1.8,
                    color: AppColors.primaryButton,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primaryButton.withValues(alpha: 0.5),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: Image.asset(payment.img),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      payment.name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
