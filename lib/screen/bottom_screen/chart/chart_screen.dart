import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Image.asset(
          "assets/images/location.jpeg",
          fit: BoxFit.cover,
          height: 100,
        ),
      ),
    );
  }
}
