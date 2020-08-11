import 'package:PGP2020/constants.dart';
import 'package:PGP2020/models/prefeito.model.dart';
import 'package:PGP2020/models/vereador.model.dart';
import 'package:PGP2020/views/perfil.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VereadoresView extends StatefulWidget {
  static const routeName = "/vereadores";

  @override
  _VereadoresViewState createState() => _VereadoresViewState();
}

class _VereadoresViewState extends State<VereadoresView> {
  Prefeito _prefeito = Prefeito.empty();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: FutureBuilder(
            future: _buscarPrefeito(),
            builder: (ctx, prefeitoSnapshot) {
              if (prefeitoSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StreamBuilder(
                  stream: Firestore.instance
                      .collection(Constants.PREFEITO)
                      .document(_prefeito.uid)
                      .collection(Constants.VEREADORES)
                      .orderBy('ordem')
                      .snapshots(),
                  builder: (ctx2, vereadoresSnapshot) {
                    if (vereadoresSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final querySnapshotVereadores =
                        vereadoresSnapshot.data as QuerySnapshot;
                    final vereadores = Vereador().fromDocumentsSnapshot(
                        querySnapshotVereadores.documents);
                    // ..sort((v1, v2) => v1.ordem > v2.ordem ? 1 : 0);
                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: vereadores.length,
                      itemBuilder: (ctx, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              PerfilView.routeName,
                              arguments: vereadores[i]),
                          child: GridTile(
                            child: Hero(
                              tag: vereadores[i].ordem,
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('assets/images/placeholder.png'),
                                image: NetworkImage(vereadores[i].imagem),
                              ),
                            ),
                            footer: LayoutBuilder(
                              builder: (BuildContext context,
                                      BoxConstraints constraints) =>
                                  Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  color: Colors.white,
                                  width: constraints.maxWidth,
                                  // decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
                                  child: Text(
                                    '${vereadores[i].nome}',
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
      // persistentFooterButtons: <Widget>[
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Text('Aperte em uma imagem para saber mais!'),
      //     ],
      //   ),
      // ],
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   onPressed: () => Navigator.of(context).pushNamed(EntrarView.routeName),
      //   child: Icon(
      //     Icons.lock,
      //     color: Theme.of(context).primaryColor,
      //   ),
      // ),
    );
  }

  Future _buscarPrefeito() async {
    final prefeito =
        await Firestore.instance.collection(Constants.PREFEITO).getDocuments();

    _prefeito = Prefeito().fromDocumentSnapshot(prefeito.documents.first);
    _prefeito.uid = prefeito.documents.first.documentID;
  }
}
