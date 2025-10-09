import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAdressTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  const MyAdressTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final isNumberField = textInputType == TextInputType.number;

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      inputFormatters:
          isNumberField ? [FilteringTextInputFormatter.digitsOnly] : [],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Pflichtfeld";
        }
        // ✅ Prüft, ob es sich um ein Zahlenfeld handelt
        if (isNumberField) {
          // Regulärer Ausdruck für internationale Telefonnummern:
          // ^         -> Anfang des Strings
          // \+?       -> optionales '+' am Anfang (für internationale Vorwahl)
          // \d        -> mindestens eine Ziffer direkt nach dem '+'
          // [0-9\s\-\(\)]{6,} -> danach mindestens 6 Zeichen, die Ziffern, Leerzeichen, Bindestriche oder Klammern sein können
          // $         -> Ende des Strings
          final phoneRegex = RegExp(r'^\+?\d[0-9\s\-\(\)]{6,}$');

          if (!phoneRegex.hasMatch(value)) {
            return "Ungültige Telefonnummer";
          }
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
