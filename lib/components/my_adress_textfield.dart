import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAdressTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final int? maxLength;

  const MyAdressTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final isNumberField =
        textInputType == TextInputType.number ||
        textInputType == TextInputType.phone;

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      inputFormatters: [
        if (maxLength != null)
          LengthLimitingTextInputFormatter(maxLength), // 🔹 stoppt Eingabe
        if (isNumberField)
          FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s\(\)]')),
      ],
      validator: (value) {
        try {
          // 🔹 Pflichtfeldprüfung
          if (value == null || value.trim().isEmpty) {
            return "Pflichtfeld";
          }

          // 🔹 Längenprüfung
          if (maxLength != null && value.length > maxLength!) {
            return "Maximal $maxLength Zeichen erlaubt";
          }

          // 🔹 Nummernprüfung (Telefon, PLZ)
          if (isNumberField) {
            final phoneRegex = RegExp(r'^\+?[0-9\s\-\(\)]{6,}$');
            if (!phoneRegex.hasMatch(value)) {
              return "Bitte eine gültige Telefonnummer eingeben";
            }
          }

          return null; // ✅ Alles ok
        } catch (e) {
          // 🔹 Falls etwas schiefläuft → Nutzerwarnung statt Absturz
          debugPrint("Validator Error: $e");
          return "Ungültige Eingabe";
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        counterText: "",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        errorMaxLines: 2,
      ),
    );
  }
}
