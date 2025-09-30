import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/navigation/floating_bottom_nav.dart';

void main() {
  runApp(const MyApp());
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
