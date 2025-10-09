import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/components/complete_button.dart';
import 'package:ykos_bbq_chicken/components/my_adress_textfield.dart';
import 'package:ykos_bbq_chicken/enum/adress_enum.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/adress_symbol.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_adress.dart';

class UpdateAdressPage extends StatefulWidget {
  final Adress adress;
  const UpdateAdressPage({super.key, required this.adress});

  @override
  State<UpdateAdressPage> createState() => _UpdateAdressPageState();
}

class _UpdateAdressPageState extends State<UpdateAdressPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _plzController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _informationController = TextEditingController();
  AdressSymbol? selectedAdressSymbol;

  @override
  void initState() {
    context.read<ViewmodelAdress>();
    _nameController.text = widget.adress.name;
    _adressController.text = widget.adress.street;
    _houseNumberController.text = widget.adress.houseNumber;
    _plzController.text = widget.adress.plz.toString();
    _placeController.text = widget.adress.place;
    _telefonController.text = widget.adress.telefon.toString();
    _informationController.text = widget.adress.information ?? "";
    selectedAdressSymbol = widget.adress.icon;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelAdress = context.watch<ViewmodelAdress>();

    List<AdressSymbol> adressSymbolList = [
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

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Adress",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // 🔹 Form umschließt alle Textfelder
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bearbeite deine Adresse",
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
                      itemCount: adressSymbolList.length,
                      itemBuilder: (context, index) {
                        final symbolFromAdressList = adressSymbolList[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAdressSymbol = symbolFromAdressList;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(10),
                            width: 90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color:
                                    selectedAdressSymbol?.name ==
                                            symbolFromAdressList.name
                                        ? Colors.deepOrange
                                        : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(symbolFromAdressList.iconData),
                                Text(symbolFromAdressList.name),
                              ],
                            ),
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
                                textInputType: TextInputType.phone,
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
                          maxLines:
                              5, // Anzahl der Zeilen, die angezeigt werden
                          minLines:
                              1, // optional, damit es bei leerem Feld klein bleibt
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
                    text: "Aktualisieren",
                    gesture: () {
                      // 🔹 Hier wird der Validator tatsächlich ausgeführt
                      if (_formKey.currentState!.validate()) {
                        //Erstellt die Adresse, anhand der angegebenen Daten.
                        final newAdress = Adress(
                          id: widget.adress.id,
                          street: _adressController.text,
                          houseNumber: _houseNumberController.text,
                          plz: int.tryParse(_plzController.text) ?? 00000,
                          place: _placeController.text,
                          icon: selectedAdressSymbol,
                          information: _informationController.text,
                          name: _nameController.text,
                          telefon: int.parse(_telefonController.text),
                        );

                        //Fügt die neue Adresse in die Liste.
                        viewModelAdress.updateAdress(newAdress);
                        // Alles korrekt ✅
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Adresse Aktualisiert')),
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
          ),
        ),
      ),
    );
  }
}
