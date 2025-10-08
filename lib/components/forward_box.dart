import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class ForwardBox extends StatelessWidget {
  final String title;
  final String announcementText;
  final IconData iconData;
  final String? img;
  const ForwardBox({
    super.key,
    required this.title,
    required this.announcementText,
    required this.iconData,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color:
              img != null
                  ? AppColors.timerTextPrimary
                  : Colors.black.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 30,
                color: img != null ? AppColors.timerTextPrimary : Colors.black,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      if (img != null && img!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 5),
                          child: Container(
                            padding: EdgeInsets.all(1),
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              child: Image.asset(img!),
                            ),
                          ),
                        ),
                      Text(
                        announcementText,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
