import 'package:PGP2020/models/vereador.model.dart';
import 'package:PGP2020/viewmodels/bottom_bar.viewmodel.dart';
import 'package:PGP2020/views/topicos/educacao.view.dart';
import 'package:PGP2020/views/topicos/mobilidade.view.dart';
import 'package:PGP2020/views/topicos/saude.view.dart';
import 'package:PGP2020/views/topicos/social.view.dart';
import 'package:PGP2020/widgets/bottom_bar.widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
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
                      const SizedBox(height: 30),
                      Card(
                        child: ListTile(
                          onTap: () => Navigator.of(context)
                              .pushNamed(EducacaoView.routeName),
                          leading: FaIcon(
                            FontAwesomeIcons.bookReader,
                            color: Theme.of(context).buttonColor,
                          ),
                          title: Text('Educação',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: Icon(
                            Icons.forward,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: ListTile(
                          onTap: () => Navigator.of(context)
                              .pushNamed(SaudeView.routeName),
                          leading: FaIcon(
                            FontAwesomeIcons.heartbeat,
                            color: Theme.of(context).buttonColor,
                          ),
                          title: Text('Saúde',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: Icon(
                            Icons.forward,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: ListTile(
                          onTap: () => Navigator.of(context)
                              .pushNamed(SocialView.routeName),
                          leading: FaIcon(
                            FontAwesomeIcons.hashtag,
                            color: Theme.of(context).buttonColor,
                          ),
                          title: Text('Social',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: Icon(
                            Icons.forward,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: ListTile(
                          onTap: () => Navigator.of(context)
                              .pushNamed(MobilidadeView.routeName),
                          leading: FaIcon(
                            FontAwesomeIcons.carSide,
                            color: Theme.of(context).buttonColor,
                          ),
                          title: Text('Mobilidade Urbana',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: Icon(
                            Icons.forward,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            BottomBar(
              BottomBarViewModel(
                facebook: _vereador.facebook,
                instagram: _vereador.instagram,
                whatsapp: _vereador.whatsapp,
                youtube: _vereador.youtube,
                twitter: _vereador.twitter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
