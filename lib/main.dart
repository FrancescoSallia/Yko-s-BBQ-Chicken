import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/login/login_page.dart';
import 'package:ykos_bbq_chicken/Service/fire_auth.dart';
import 'package:ykos_bbq_chicken/firebase_options.dart';
import 'package:ykos_bbq_chicken/navigation/floating_bottom_nav.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_adress.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_auth.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_fire.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_fire_auth.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';
import "package:firebase_core/firebase_core.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Checked user if the user is deleted from server, befor the app starts!
  final user = FireAuth.auth.currentUser;
  if (user != null) {
    try {
      await user.reload(); // aktualisiert den Status vom Server
      if (FireAuth.auth.currentUser == null) {
        // User existiert nicht mehr auf Firebase
        await FireAuth.auth.signOut();
      }
    } catch (e) {
      // Falls reload fehlschlägt (z. B. weil gelöscht)
      await FireAuth.auth.signOut();
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewmodelMenu()),
        ChangeNotifierProvider(create: (_) => ViewmodelAdress()),
        ChangeNotifierProvider(create: (_) => ViewmodelAuth()),
        ChangeNotifierProvider(create: (_) => ViewmodelFireAuth()),
        ChangeNotifierProvider(create: (_) => ViewmodelFire()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: (context, child) {
      //   return Center(
      //     child: ConstrainedBox(
      //       constraints: BoxConstraints(maxWidth: 450),
      //       child: child,
      //     ),
      //   );
      // },
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FireAuth.auth.authStateChanges(),
        builder: (context, snapshot) {
          // Warten, bis Firebase den aktuellen Status bestimmt hat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Wenn Firebase kurzzeitig null sendet (z. B. beim Reload),
          // vermeiden wir das Flackern, indem wir den letzten Zustand behalten.
          final user = snapshot.data;
          if (user != null) {
            return const FloatingBottomNav();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
