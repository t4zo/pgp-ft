import 'package:PGP2020/constants.dart';
import 'package:PGP2020/models/prefeito.model.dart';
import 'package:PGP2020/views/plano_governo_details.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlanoGovernoView extends StatelessWidget {
  static const routeName = "/planoGoverno";

  @override
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
              return ListView(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Text(
                      'Plano de Governo Participativo',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline6.fontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'A Plataforma do Programa de Governo Participativo (PGP) do pré-candidato e atual prefeito de Juazeiro Bahia, Paulo Bonfim (PT) se propõe ao envolvimento de toda a sociedade na discussão propositiva de temas que interessam à população como um todo – através de lives, reuniões virtuais e coletas de propostas pelo próprio aplicativo dividido por eixos.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Abaixo, temos os 13 principais eixos de discussão com informações básicas e com o espaço de coleta de propostas.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...prefeito.planoGoverno
                      .map((planoGoverno) => Card(
                            child: ListTile(
                              onTap: () => Navigator.of(context).pushNamed(
                                  PlanoGovernoDetailsView.routeName,
                                  arguments: planoGoverno.id),
                              title: Text(planoGoverno.nome,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              trailing: Icon(
                                Icons.forward,
                                color: Colors.black,
                              ),
                            ),
                          ))
                      .toList(),
                ],
              );
            }),
      ),
    );
  }
}
