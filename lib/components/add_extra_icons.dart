import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class AddExtraIcons extends StatefulWidget {
  final Extra extraItem;
  const AddExtraIcons({super.key, required this.extraItem});

  @override
  State<AddExtraIcons> createState() => _AddExtraIconsState();
}

class _AddExtraIconsState extends State<AddExtraIcons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.extraItem.name,
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
        Spacer(),

        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            widget.extraItem.price % 1 == 0
                ? "${widget.extraItem.price.toInt()} €" // glatte Zahl
                : "${widget.extraItem.price.toStringAsFixed(2).replaceAll('.', ',')} €", // 2 Nachkommastellen
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton.filled(
              style: IconButton.styleFrom(
                iconSize: 12,
                backgroundColor: AppColors.primaryButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                minimumSize: const Size(18, 18),
              ),
              onPressed: () {
                setState(() {
                  if (widget.extraItem.anzahl > 0) {
                    widget.extraItem.anzahl--;
                  }
                });
              },
              icon: Icon(Icons.remove),
            ),
            SizedBox(
              width: 15,
              child: Center(child: Text(widget.extraItem.anzahl.toString())),
            ),

            IconButton.filled(
              style: IconButton.styleFrom(
                iconSize: 12,
                backgroundColor: AppColors.timerPrimary2,
                foregroundColor: AppColors.primaryButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                minimumSize: const Size(18, 18),
              ),
              onPressed: () {
                setState(() {
                  widget.extraItem.anzahl++;
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
