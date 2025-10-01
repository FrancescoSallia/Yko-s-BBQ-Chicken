import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text("Bestellung:"),
              SizedBox(width: 10),
              Text("#245444"),
            ],
          ),
        ],
      ),
    );
  }
}
