import 'package:flutter/material.dart';

class SaudeView extends StatelessWidget {
  static const routeName = "/saude";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Saude'),
        ),
      ),
    );
  }
}
