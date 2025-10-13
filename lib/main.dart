import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/firebase_options.dart';
import 'package:ykos_bbq_chicken/navigation/floating_bottom_nav.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_adress.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_auth.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';
import "package:firebase_core/firebase_core.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewmodelMenu()),
        ChangeNotifierProvider(create: (_) => ViewmodelAdress()),
        ChangeNotifierProvider(create: (_) => ViewmodelAuth()),
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
      home: FloatingBottomNav(),
      // home: CheckoutPage(),
      // home: LoginPage(),
      // home: DetailPage(),
    );
  }
}
