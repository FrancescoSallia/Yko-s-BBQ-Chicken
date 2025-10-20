import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_add_adress.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_options.dart';
import 'package:ykos_bbq_chicken/Pages/Ordering/update_adress_page.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_adress.dart';

class AdressPage extends StatefulWidget {
  const AdressPage({super.key});

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModelAdress = context.read<ViewmodelAdress>();
      viewModelAdress.fetchAdressList();

      if (viewModelAdress.error != null) {
        AnimatedSnackBar.material(
          viewModelAdress.error.toString(),
          type: AnimatedSnackBarType.error,
        ).show(context);
        viewModelAdress.clearError();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelAdress = context.watch<ViewmodelAdress>();

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
              itemCount: viewModelAdress.adressList.length,
              itemBuilder: (context, index) {
                final adress = viewModelAdress.adressList[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).pop(adress),
                  child: Container(
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
                          child: Icon(
                            adress.icon?.iconData ?? Icons.home_work_outlined,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                adress.name,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                "${adress.street}, ${adress.houseNumber} ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                "${adress.plz}, ${adress.place}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                adress.telefon.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              barrierColor: Colors.black54,
                              useSafeArea: true,
                              backgroundColor: Colors.white70,
                              isScrollControlled: true,
                              builder: (context) {
                                return FractionallySizedBox(
                                  heightFactor: 0.35,
                                  child: SheetOptions(
                                    confirmDeleteDialogFunction: () async {
                                      final navigator = Navigator.of(context);
                                      final snack = IconSnackBar.show(
                                        context,
                                        label: "Adresse Erfolgreich entfernt",
                                        snackBarType: SnackBarType.success,
                                      );
                                      await viewModelAdress
                                          .removeFromAdressList(adress);
                                      if (!mounted) return;
                                      snack;
                                      navigator.pop();
                                      navigator.pop();
                                    },
                                    navigateToUpdateFunction: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (context) => UpdateAdressPage(
                                                adress: adress,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Icon(Icons.more_horiz, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
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
