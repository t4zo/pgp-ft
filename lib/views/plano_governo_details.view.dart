import 'dart:io';

import 'package:PGP2020/constants.dart';
import 'package:PGP2020/models/plano_governo.model.dart';
import 'package:PGP2020/models/prefeito.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanoGovernoDetailsView extends StatefulWidget {
  static const routeName = "/planoGovernoDetails";
  @override
  _PlanoGovernoDetailsViewState createState() =>
      _PlanoGovernoDetailsViewState();
}

class _PlanoGovernoDetailsViewState extends State<PlanoGovernoDetailsView> {
  final _form = GlobalKey<FormState>();

  // String _nome;
  String _mensagem;
  String _email = 'taciodesouzacampos@gmail.com';

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments as int;
    final _mensagemFocusNode = FocusNode();

    final body = SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: StreamBuilder(
            stream:
                Firestore.instance.collection(Constants.PREFEITO).snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                );
              }
              final querySnapshot = snapshot.data as QuerySnapshot;
              final prefeito = Prefeito()
                  .fromDocumentsSnapshot(querySnapshot.documents)
                  .first;
              final planoGoverno = prefeito.planoGoverno
                  .singleWhere((planoGoverno) => planoGoverno.id == _id);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20, bottom: 30),
                      // decoration: BoxDecoration(
                      //   border: Border(bottom: BorderSide(color: Colors.black)),
                      // ),
                      child: Text(
                        planoGoverno.nome,
                        style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline6.fontSize),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Text(planoGoverno.descricao),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        // Card(
                        //   child: TextFormField(
                        //     textInputAction: TextInputAction.next,
                        //     onFieldSubmitted: (_) => FocusScope.of(context)
                        //         .requestFocus(_mensagemFocusNode),
                        //     decoration:
                        //         const InputDecoration(labelText: 'Nome'),
                        //     validator: (value) {
                        //       if (value.isEmpty)
                        //         return 'Por favor, informe seu nome';
                        //       return null;
                        //     },
                        //     onSaved: (value) => _nome = value,
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        Card(
                          child: Platform.isIOS
                              ? CupertinoTextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 4,
                                  maxLines: null,
                                  focusNode: _mensagemFocusNode,
                                  placeholder: '  Fale com a gente!',
                                  onSubmitted: (_) =>
                                      _launchToEmail(planoGoverno),
                                )
                              : TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 4,
                                  maxLines: null,
                                  focusNode: _mensagemFocusNode,
                                  decoration: InputDecoration(
                                      hintText: '  Fale com a gente!',
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            _launchToEmail(planoGoverno),
                                        icon: Icon(Icons.send),
                                      )),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return 'Por favor, informe sua mensagem';
                                    return null;
                                  },
                                  onSaved: (value) => _mensagem = value,
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: body)
        : Scaffold(body: body);
  }

  void _launchToEmail(PlanoGoverno planoGoverno) {
    _form.currentState.validate();
    _form.currentState.save();

    final Uri _emailLaunchUri =
        Uri(scheme: 'mailto', path: _email, queryParameters: {
      'subject': 'Eixo: ${planoGoverno.nome}',
      'body': _mensagem
      // 'body': 'Nome: $_nome\n\n$_mensagem'
    });

    // mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
    launch(_emailLaunchUri.toString());
  }
}
