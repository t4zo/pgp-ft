import 'dart:io';

import 'package:PGP2020/models/vereador.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_share/flutter_share.dart';

class PerfilView extends StatelessWidget {
  static const routeName = "/perfil";

  // Future<void> share() async {
  //   await FlutterShare.share(
  //       title: 'Paulo Bomfim 2020',
  //       text: 'Veja só que legal o novo aplicativo do nosso prefeito!',
  //       linkUrl: 'https://play.google.com/store/apps/details?id=xyz.saca',
  //       chooserTitle: 'Example Chooser Title');
  // }

  @override
  Widget build(BuildContext context) {
    final Vereador _vereador = ModalRoute.of(context).settings.arguments;

    final body = SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: _vereador.nome),
                        TextSpan(text: ' - '),
                        TextSpan(text: _vereador.numero),
                      ]),
                    ),
                    background: Hero(
                      tag: _vereador.ordem,
                      child: Image.network(
                        _vereador.imagem,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Text(
                        'Sobre',
                        style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline5.fontSize),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      child: Text(_vereador.biografia),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          // BottomBar(
          //   BottomBarViewModel(
          //     facebook: _vereador.facebook,
          //     instagram: _vereador.instagram,
          //     whatsapp: _vereador.whatsapp,
          //     youtube: _vereador.youtube,
          //     twitter: _vereador.twitter,
          //   ),
          // ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: body)
        : Scaffold(body: body);
  }
}
