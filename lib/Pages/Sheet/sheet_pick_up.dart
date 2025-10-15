import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_user.dart';

class SheetPickUp extends StatefulWidget {
  const SheetPickUp({super.key});

  @override
  State<SheetPickUp> createState() => _SheetPickUpState();
}

class _SheetPickUpState extends State<SheetPickUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();

  @override
  void initState() {
    final viewModelAuth = context.read<ViewmodelUser>();
    if (viewModelAuth.pickUpUser == null) return;
    _nameController.text = viewModelAuth.pickUpUser!.name;
    _lastNameController.text = viewModelAuth.pickUpUser!.lastName;
    _telefonController.text = viewModelAuth.pickUpUser!.telefon;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelAuth = context.watch<ViewmodelUser>();

    return StatefulBuilder(
      // ist für die echtzeit aktualisierung wie setState nur mit setModalState in einem Sheet.
      builder: (context, setModalState) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          widthFactor: 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 20,
            children: [
              Text(
                "Geben Sie ihre Personenbezogenen Daten ein.",
                softWrap: true,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text, // wichtig!
                  decoration: InputDecoration(
                    labelText: "Vorname",
                    hintText: "z.ß. Max",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setModalState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _lastNameController,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text, // wichtig!
                  decoration: InputDecoration(
                    labelText: "Nachname",
                    hintText: "z.ß. Mustermann",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setModalState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _telefonController,
                  keyboardType: TextInputType.phone, // wichtig!
                  decoration: InputDecoration(
                    labelText: "Telefonnummer",
                    hintText: "z.ß. 0176234567",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setModalState(() {});
                  },
                ),
              ),

              SizedBox(height: 5),
              TextButton(
                onPressed:
                    _nameController.text.trim().isEmpty ||
                            _lastNameController.text.trim().isEmpty ||
                            _telefonController.text.trim().isEmpty
                        ? null
                        : () {
                          viewModelAuth.updatePickUpUser(
                            _nameController.text,
                            _lastNameController.text,
                            _telefonController.text,
                          );
                          Navigator.pop(context);
                        },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  decoration: BoxDecoration(
                    boxShadow:
                        _nameController.text.trim().isEmpty ||
                                _lastNameController.text.trim().isEmpty ||
                                _telefonController.text.trim().isEmpty
                            ? []
                            : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 3,
                                offset: Offset(2, 2),
                              ),
                            ],
                    borderRadius: BorderRadius.circular(100),
                    color:
                        _nameController.text.trim().isEmpty ||
                                _lastNameController.text.trim().isEmpty ||
                                _telefonController.text.trim().isEmpty
                            ? Colors.black.withValues(alpha: 0.1)
                            : AppColors.primary,
                  ),
                  child: Text(
                    "Speichern",
                    style: GoogleFonts.inter(
                      color:
                          _nameController.text.trim().isEmpty ||
                                  _lastNameController.text.trim().isEmpty ||
                                  _telefonController.text.trim().isEmpty
                              ? Colors.black.withValues(alpha: 0.3)
                              : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
