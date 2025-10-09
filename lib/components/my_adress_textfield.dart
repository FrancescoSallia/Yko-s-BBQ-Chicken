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
    // 🔹 Prüfen, ob es sich um ein Zahlenfeld handelt
    final isPhoneField = textInputType == TextInputType.phone;
    final isPlzField =
        textInputType == TextInputType.number ||
        labelText.toLowerCase().contains('plz');

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.words, // 🔹 erster Buchstabe groß
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),

      // 🔹 Eingabeformatierer unterscheiden zwischen Telefon & PLZ
      inputFormatters: [
        if (maxLength != null)
          LengthLimitingTextInputFormatter(
            maxLength,
          ), // stoppt Eingabe bei max Länge
        if (isPhoneField)
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9+\-\s\(\)]'),
          ), // nur gültige Zeichen
        if (isPlzField)
          FilteringTextInputFormatter.digitsOnly, // nur Ziffern für PLZ
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

          // 🔹 Telefonnummer validieren
          if (isPhoneField) {
            final phoneRegex = RegExp(r'^\+?[0-9\s\-\(\)]{6,}$');
            if (!phoneRegex.hasMatch(value)) {
              return "Bitte eine gültige Telefonnummer eingeben";
            }
          }

          // 🔹 PLZ validieren (Deutschland: 5 Ziffern)
          if (isPlzField) {
            final plzRegex = RegExp(r'^\d{5}$');
            if (!plzRegex.hasMatch(value)) {
              return "Bitte eine gültige PLZ eingeben";
            }
          }

          return null; // ✅ alles ok
        } catch (e) {
          debugPrint("Validator Error: $e");
          return "Ungültige Eingabe"; // 🔹 Fehler auffangen, kein Absturz
        }
      },

      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        counterText: "", // 🔹 Zähler unten ausblenden
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        errorMaxLines: 2, // 🔹 Fehlermeldung nicht abschneiden
      ),
    );
  }
}
