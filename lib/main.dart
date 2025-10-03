import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/navigation/floating_bottom_nav.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ViewmodelMenu())],
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
      debugShowCheckedModeBanner: false,
      home: FloatingBottomNav(),
      // home: LoginPage(),
      // home: DetailPage(),
    );
  }
}
