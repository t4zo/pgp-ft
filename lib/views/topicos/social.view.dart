import 'package:flutter/material.dart';

class SocialView extends StatelessWidget {
  static const routeName = "/social";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Social'),
        ),
      ),
    );
  }
}
