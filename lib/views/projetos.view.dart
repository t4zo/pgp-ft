import 'package:flutter/material.dart';

class ProjetosView extends StatelessWidget {
  static const routeName = "/projetos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Projetos'),
        ),
      ),
    );
  }
}
