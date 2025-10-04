import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/extra.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class AddExtraIcons extends StatefulWidget {
  final Extra extraItem;
  Food item;
  AddExtraIcons({super.key, required this.extraItem, required this.item});

  @override
  State<AddExtraIcons> createState() => _AddExtraIconsState();
}

class _AddExtraIconsState extends State<AddExtraIcons> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ViewmodelMenu>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.extraItem.name,
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            Spacer(),

            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(widget.extraItem.price.toEuroString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // REMOVE Button
                Visibility(
                  visible: widget.extraItem.anzahl > 0 ? true : false,
                  child: IconButton.filled(
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
                        final extraItem = widget.extraItem;
                        final item = widget.item;

                        viewModelMenu.countDecrease(extraItem, item);
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ),

                //COUNT Text
                SizedBox(
                  width: 15,
                  child: Center(
                    child: Text(widget.extraItem.anzahl.toString()),
                  ),
                ),

                // ADD Button
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
                      final extraItem = widget.extraItem;
                      final item = widget.item;
                      //Count increasement
                      viewModelMenu.countIncrease(extraItem, item);
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        Divider(height: 0),
      ],
    );
  }
}
