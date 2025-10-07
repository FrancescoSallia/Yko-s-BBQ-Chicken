import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class ForwardBox extends StatelessWidget {
  final String title;
  final String announcementText;
  final IconData iconData;
  const ForwardBox({
    super.key,
    required this.title,
    required this.announcementText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(iconData, size: 30),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    announcementText,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textFieldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 20),
        ],
      ),
    );
  }
}