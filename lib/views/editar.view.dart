import 'dart:io';
import 'dart:math';

import 'package:PGP2020/constants.dart';
import 'package:PGP2020/models/prefeito.model.dart';
import 'package:PGP2020/models/vereador.model.dart';
import 'package:PGP2020/views/home.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class EditarView extends StatefulWidget {
  static const routeName = '/editar';

  @override
  _EditarViewState createState() => _EditarViewState();
}

class _EditarViewState extends State<EditarView> {
  final _scaffold = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();

  final _numeroFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _facebookFocusNode = FocusNode();
  final _instagramFocusNode = FocusNode();
  final _whatsappFocusNode = FocusNode();
  final _youtubeFocusNode = FocusNode();
  final _twitterFocusNode = FocusNode();

  Prefeito _prefeito = Prefeito.empty();
  Vereador _vereador = Vereador.empty();
  bool _ocupado = false;
  bool _removendo = false;
  bool _imagemRemota = true;

  File _image;

  @override
  void dispose() {
    super.dispose();
    _numeroFocusNode.dispose();
    _emailFocusNode.dispose();
    _facebookFocusNode.dispose();
    _instagramFocusNode.dispose();
    _whatsappFocusNode.dispose();
    _youtubeFocusNode.dispose();
    _twitterFocusNode.dispose();
  }

  Future _handleImageAsync() async {
    final image = await _pickImageAsync(ImageSource.gallery);
    if (image != null) {
      await _saveLocalImageAsync(image);
    }
  }

  Future<PickedFile> _pickImageAsync(ImageSource imageSource) async {
    final picker = ImagePicker();
    return await picker.getImage(
      source: imageSource,
      maxHeight: 200,
    );
  }

  Future _saveLocalImageAsync(PickedFile pickedFile) async {
    setState(() {
      _image = File(pickedFile.path);
      _imagemRemota = false;
    });
  }

  Future _uploadImageAsync() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('PGP2020')
        .child('images')
        .child('${_vereador.uid}.${_image.path.split('.').last}');
    await ref.putFile(_image).onComplete;

    final url = await ref.getDownloadURL();
    _vereador.imagem = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Editar informações'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _confirmarRemocao,
          )
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: _removendo
              ? Container()
              : FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor),
                      );
                    }
                    FirebaseUser usuario = futureSnapshot.data;
                    return FutureBuilder(
                        future: _buscarOuCriarVereador(usuario),
                        builder: (ctx, futureSnapshot2) {
                          if (futureSnapshot2.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            final vereador = futureSnapshot2.data;
                            return SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 40),
                                    child: Form(
                                      key: _form,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: GestureDetector(
                                              onTap: _handleImageAsync,
                                              child: _imagemRemota
                                                  ? Image.network(
                                                      _vereador.imagem)
                                                  : Image.file(_image),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            initialValue: vereador.nome,
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _numeroFocusNode),
                                            decoration: const InputDecoration(
                                                labelText: 'Nome'),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return 'Por favor, informe seu nome';
                                              return null;
                                            },
                                            onSaved: (value) =>
                                                _vereador.nome = value,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            initialValue: vereador.numero,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _numeroFocusNode,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _emailFocusNode),
                                            decoration: const InputDecoration(
                                                labelText: 'Número'),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return 'Por favor, informe seu numero';
                                              return null;
                                            },
                                            onSaved: (value) =>
                                                _vereador.numero = value,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            initialValue: vereador.email,
                                            // keyboardType:
                                            //     TextInputType.multiline,
                                            // minLines: 4,
                                            // maxLines: null,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _emailFocusNode,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _facebookFocusNode),
                                            decoration: const InputDecoration(
                                                labelText: 'Email'),
                                            onSaved: (value) =>
                                                _vereador.email = value,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            initialValue: vereador.facebook,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _facebookFocusNode,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _instagramFocusNode),
                                            decoration: const InputDecoration(
                                                labelText: 'Link Facebook'),
                                            onSaved: (value) =>
                                                _vereador.facebook = value,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            initialValue: vereador.instagram,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _instagramFocusNode,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _whatsappFocusNode),
                                            decoration: const InputDecoration(
                                                labelText: 'Link Instagram'),
                                            onSaved: (value) =>
                                                _vereador.instagram = value,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            initialValue: vereador.whatsapp,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _whatsappFocusNode,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _youtubeFocusNode),
                                            decoration: const InputDecoration(
                                                labelText: 'Link Whatsapp'),
                                            onSaved: (value) =>
                                                _vereador.whatsapp = value,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            initialValue: vereador.youtube,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _youtubeFocusNode,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _twitterFocusNode),
                                            decoration: const InputDecoration(
                                                labelText: 'Link Youtube'),
                                            onSaved: (value) =>
                                                _vereador.youtube = value,
                                          ),
                                          SizedBox(height: 40),
                                          TextFormField(
                                            initialValue: vereador.twitter,
                                            textInputAction:
                                                TextInputAction.done,
                                            focusNode: _twitterFocusNode,
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode()),
                                            decoration: const InputDecoration(
                                                labelText: 'Link Twitter'),
                                            onSaved: (value) =>
                                                _vereador.twitter = value,
                                          ),
                                          SizedBox(height: 40),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              RaisedButton(
                                                child: const Text('Sair'),
                                                elevation: 2,
                                                color: Colors.grey,
                                                textColor: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline6
                                                    .color,
                                                onPressed: _sair,
                                              ),
                                              const SizedBox(width: 40),
                                              RaisedButton(
                                                child: _ocupado
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : const Text('Atualizar'),
                                                elevation: 2,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                textColor: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline6
                                                    .color,
                                                onPressed: () =>
                                                    _atualizar(usuario),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                  }),
        ),
      ),
    );
  }

  Future _buscarOuCriarVereador(FirebaseUser usuario) async {
    final prefeitoQuerySnapshot =
        await Firestore.instance.collection(Constants.PREFEITO).getDocuments();

    final prefeito =
        Prefeito().fromDocumentSnapshot(prefeitoQuerySnapshot.documents.first);
    prefeito.uid = prefeitoQuerySnapshot.documents.first.documentID;

    final vereadoresReference = Firestore.instance
        .collection(Constants.PREFEITO)
        .document(prefeitoQuerySnapshot.documents.first.documentID)
        .collection(Constants.VEREADORES)
        .document(usuario.uid);
    final vereadorDocument = await vereadoresReference.get();

    Vereador vereador;

    if (!_removendo) {
      if (vereadorDocument.exists) {
        vereador = Vereador().fromDocumentSnapshot(vereadorDocument);
      } else {
        final querySnapshot = await Firestore.instance
            .collection(Constants.PREFEITO)
            .document(prefeitoQuerySnapshot.documents.first.documentID)
            .collection(Constants.VEREADORES)
            .getDocuments();

        final vereadores =
            Vereador().fromDocumentsSnapshot(querySnapshot.documents);
        vereador = _vereador;
        int ultimaOrdem = 0;
        if (vereadores.isNotEmpty) {
          ultimaOrdem =
              vereadores.map((vereador) => vereador.ordem).reduce(max);
        }

        vereador.uid = usuario.uid;
        vereador.ordem = ++ultimaOrdem;
        await vereadoresReference.setData(vereador.toJson());
      }
      _prefeito = prefeito;
      _vereador = vereador;
    }

    return vereador;
  }

  Future _atualizar(FirebaseUser usuario) async {
    final isValid = _form.currentState.validate();
    if (!isValid) return "Algum campo está inválido";

    _form.currentState.save();

    setState(() {
      _ocupado = true;
    });

    await _uploadImageAsync();
    await Firestore.instance
        .collection(Constants.PREFEITO)
        .document(_prefeito.uid)
        .collection(Constants.VEREADORES)
        .document(_vereador.uid)
        .updateData(_vereador.toJson());

    setState(() {
      _ocupado = false;
    });
  }

  Future _sair() async {
    await Navigator.of(context).pushReplacementNamed(HomeView.routeName);
    await FirebaseAuth.instance.signOut();
  }

  Future _confirmarRemocao() async {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Remover Conta'),
              content: Text('Deseja realmente remover conta?'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                    child: _ocupado
                        ? Center(
                            child: CircularProgressIndicator(strokeWidth: 3),
                          )
                        : const Text(
                            'Remover',
                            style: TextStyle(color: Colors.red),
                          ),
                    onPressed: () async {
                      await _remover();
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }

  Future _remover() async {
    setState(() {
      _ocupado = true;
      _removendo = true;
    });

    final user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection(Constants.PREFEITO)
        .document(_prefeito.uid)
        .collection(Constants.VEREADORES)
        .document(_vereador.uid)
        .delete();
    await user.delete();

    await Navigator.of(context).pushReplacementNamed(HomeView.routeName);

    setState(() {
      _ocupado = false;
      _removendo = false;
    });
  }
}
