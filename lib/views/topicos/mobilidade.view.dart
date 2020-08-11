import 'package:flutter/material.dart';

class MobilidadeView extends StatelessWidget {
  static const routeName = "/mobilidade";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Mobilidade Urbana'),
        ),
      ),
    );
  }
}
