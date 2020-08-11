import 'package:flutter/material.dart';

class RealizacoesView extends StatelessWidget {
  static const routeName = "/realizacoes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Realizações'),
        ),
      ),
    );
  }
}
