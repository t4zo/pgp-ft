import 'dart:io';
import 'package:PGP2020/viewmodels/bottom_bar.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  final BottomBarViewModel _bottomBarViewModel;

  BottomBar(this._bottomBarViewModel);

  void _launchFacebook(String pageId) async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/$pageId';
    } else {
      fbProtocolUrl = 'fb://page/$pageId';
    }

    String fallbackUrl = 'https://www.facebook.com/$pageId';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).buttonTheme.colorScheme.primary,
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
              onPressed: () => _launchFacebook(_bottomBarViewModel.facebook),
              icon: FaIcon(
                FontAwesomeIcons.facebookF,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
              onPressed: () => launch(_bottomBarViewModel.instagram),
              icon: FaIcon(
                FontAwesomeIcons.instagram,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
              onPressed: () => launch(_bottomBarViewModel.whatsapp),
              icon: FaIcon(
                FontAwesomeIcons.whatsapp,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
              onPressed: () => launch(_bottomBarViewModel.youtube),
              icon: FaIcon(
                FontAwesomeIcons.youtube,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
              onPressed: () => launch(_bottomBarViewModel.twitter),
              icon: FaIcon(
                FontAwesomeIcons.twitter,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
