import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/login/login_page.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_fire_auth.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // @override
  // void initState() {
  //   final viewModelFireAuth = context.read<ViewmodelFireAuth>();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModelFireAuth = context.watch<ViewmodelFireAuth>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModelFireAuth.logoutError != null) {
        AnimatedSnackBar.material(
          viewModelFireAuth.logoutError.toString(),
          type: AnimatedSnackBarType.error,
        ).show(context);
      }
    });

    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            Navigator.of(context).pop(); // Drawer schließen
            await viewModelFireAuth.logOut();
          },
          child: Text("Log out"),
        ),
      ),
    );
  }
}
