import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:PGP2020/constants.dart';
import 'package:PGP2020/models/prefeito.model.dart';
import 'package:PGP2020/viewmodels/bottom_bar.viewmodel.dart';
import 'package:PGP2020/views/agenda.view.dart';
import 'package:PGP2020/views/plano_governo.view.dart';
import 'package:PGP2020/views/vereadores.dart';
import 'package:PGP2020/widgets/bottom_bar.widget.dart';

class HomeView extends StatelessWidget {
  static const routeName = "/";

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream:
                Firestore.instance.collection(Constants.PREFEITO).snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final querySnapshot = snapshot.data as QuerySnapshot;
              final prefeito = Prefeito()
                  .fromDocumentsSnapshot(querySnapshot.documents)
                  .first;
              return Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   border: Border(bottom: BorderSide(color: Colors.black)),
                    // ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Image.network('${prefeito.imagens.home}'),
                        // Positioned(
                        //   bottom: 0,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: <Widget>[
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 8.0),
                        //         child: RaisedButton(
                        //           child: const Text('Obras'),
                        //           onPressed: () => Navigator.of(context)
                        //               .pushNamed(ObrasView.routeName),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 8.0),
                        //         child: RaisedButton(
                        //           child: const Text('Realizações'),
                        //           onPressed: () => Navigator.of(context)
                        //               .pushNamed(RealizacoesView.routeName),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 8.0),
                        //         child: RaisedButton(
                        //           child: const Text('Projetos'),
                        //           onPressed: () => Navigator.of(context)
                        //               .pushNamed(ProjetosView.routeName),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(PlanoGovernoView.routeName),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                '${prefeito.imagens.planoGoverno}',
                                fit: BoxFit.scaleDown,
                                width: 120,
                              ),
                              Text('Plano de Governo...'),
                              // Text('Plano de Governo Participativo'),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(VereadoresView.routeName),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                '${prefeito.imagens.vereadores}',
                                fit: BoxFit.scaleDown,
                                width: 120,
                              ),
                              Text('Pré Candidatos...'),
                              // Text('Pré Candidatos a Vereadores'),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(AgendaView.routeName),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                prefeito.imagens.agenda,
                                fit: BoxFit.scaleDown,
                                width: 120,
                              ),
                              Text('Agenda'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomBar(
                    BottomBarViewModel(
                      facebook: prefeito.facebook,
                      instagram: prefeito.instagram,
                      whatsapp: prefeito.whatsapp,
                      youtube: prefeito.youtube,
                      twitter: prefeito.twitter,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
