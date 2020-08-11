import 'package:flutter/material.dart';

class ObrasView extends StatelessWidget {
  static const routeName = "/obras";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Obras'),
        ),
      ),
    );
  }
}
