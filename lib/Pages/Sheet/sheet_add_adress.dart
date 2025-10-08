import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/components/complete_button.dart';
import 'package:ykos_bbq_chicken/components/my_adress_textfield.dart';
import 'package:ykos_bbq_chicken/enum/adress_enum.dart';
import 'package:ykos_bbq_chicken/model/adress_symbol.dart';

class SheetAddAdress extends StatefulWidget {
  const SheetAddAdress({super.key});

  @override
  State<SheetAddAdress> createState() => _SheetAddAdressState();
}

class _SheetAddAdressState extends State<SheetAddAdress> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _plzController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _informationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<AdressSymbol> _adressSymbol = [
      AdressSymbol(
        name: AdressEnum.suit.labelText,
        iconData: AdressEnum.suit.label,
      ),
      AdressSymbol(
        name: AdressEnum.house.labelText,
        iconData: AdressEnum.house.label,
      ),
      AdressSymbol(
        name: AdressEnum.office.labelText,
        iconData: AdressEnum.office.label,
      ),
      AdressSymbol(
        name: AdressEnum.outdoor.labelText,
        iconData: AdressEnum.outdoor.label,
      ),
    ];
    return Form(
      key: _formKey, // 🔹 Form umschließt alle Textfelder
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Erstelle eine neue Adresse",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            //AdressSymbol-List
            SizedBox(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _adressSymbol.length,
                itemBuilder: (context, index) {
                  final adressSymbol = _adressSymbol[index];
                  return Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.all(10),
                    width: 90,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(adressSymbol.iconData),
                        Text(adressSymbol.name),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20,
              ),
              child: Column(
                spacing: 12,
                children: [
                  MyAdressTextfield(
                    controller: _nameController,
                    labelText: "Name",
                    hintText: "z.ß. Max Mustermann",
                    textInputType: TextInputType.name,
                  ),

                  MyAdressTextfield(
                    controller: _adressController,
                    labelText: "Straße",
                    hintText: "z.ß. Müllerstraße",
                    textInputType: TextInputType.streetAddress,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyAdressTextfield(
                          controller: _houseNumberController,
                          labelText: "HausNr.",
                          hintText: "z.ß. 38a",
                          textInputType: TextInputType.streetAddress,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: MyAdressTextfield(
                          controller: _plzController,
                          labelText: "Postleitzahl",
                          hintText: "z.ß. 12167",
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  MyAdressTextfield(
                    controller: _placeController,
                    labelText: "Ort",
                    hintText: "z.ß. Berlin",
                    textInputType: TextInputType.name,
                  ),
                  MyAdressTextfield(
                    controller: _telefonController,
                    labelText: "Telefon",
                    hintText: "z.ß. 0157345678",
                    textInputType: TextInputType.phone,
                  ),
                  TextFormField(
                    controller: _informationController,
                    keyboardType: TextInputType.multiline, // wichtig!
                    maxLines: 5, // Anzahl der Zeilen, die angezeigt werden
                    minLines:
                        1, // optional, damit es bei leerem Feld klein bleibt
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Bitte ausfüllen";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Kurier-Information",
                      hintText:
                          "z.ß. Bitte nicht klingeln o. nach dem Fahrstuhl auf der linken Seite ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            CompleteButton(
              text: "Speichern",
              gesture: () {
                // 🔹 Hier wird der Validator tatsächlich ausgeführt
                if (_formKey.currentState!.validate()) {
                  // Alles korrekt ✅
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adresse gespeichert')),
                  );
                } else {
                  // Fehler — das Feld zeigt jetzt den roten Rahmen ❌
                }
              },
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
