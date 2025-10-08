import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_add_adress.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_options.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class AdressPage extends StatefulWidget {
  const AdressPage({super.key});

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.secondary,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 0.9, // 90% der Bildschirmhöhe
                    child: const SheetAddAdress(),
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
        title: Text(
          "Adress",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          //HEADER
          Divider(color: Colors.black),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Icon(Icons.home, size: 28),
                ),
                SizedBox(width: 10),
                Text(
                  "Wunschadresse",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Wählen Sie Ihre Liefer-Adresse aus.",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),

          //Adress-List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1.5, color: Colors.black),
                        ),
                        child: Icon(Icons.home_work_outlined),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text("Name", softWrap: true),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text("Straße, Hausnummer ", softWrap: true),
                          ),
                          Text("PLZ, ORT"),
                          Text("Telefon"),
                        ],
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.black54,
                            useSafeArea: true,
                            backgroundColor: Colors.white54,
                            isScrollControlled: true,
                            builder: (context) {
                              return FractionallySizedBox(
                                heightFactor: 0.35,
                                child: const SheetOptions(),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: Center(
                            child: Icon(Icons.more_horiz, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
