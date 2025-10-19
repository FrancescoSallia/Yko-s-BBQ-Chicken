import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class SheetNotePage extends StatefulWidget {
  final Food foodItem;
  const SheetNotePage({super.key, required this.foodItem});

  @override
  State<SheetNotePage> createState() => _SheetNotePageState();
}

class _SheetNotePageState extends State<SheetNotePage> {
  final TextEditingController _textFieldController = TextEditingController();

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

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   "Anmerkung zu deinem Gericht hinzufügen",
          //   style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel, size: 26, color: Colors.black),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Notiz",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _textFieldController.clear();
                    });
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                hintText: "z.ß Ohne Zwiebeln etc.",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: 180,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    widget.foodItem.note = _textFieldController.text;
                    viewModelMenu.updateMeal(widget.foodItem);
                    Navigator.of(context).pop();
                  });
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  backgroundColor: AppColors.primaryButton,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Notiz Speichern"),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
