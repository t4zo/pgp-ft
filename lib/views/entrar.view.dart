import 'dart:io';

import 'package:PGP2020/viewmodels/entrar.viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'editar.view.dart';

class EntrarView extends StatefulWidget {
  static const routeName = "/entrar";

  @override
  _EntrarViewState createState() => _EntrarViewState();
}

class _EntrarViewState extends State<EntrarView> {
  final _scaffold = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final _senhaFocusNode = FocusNode();

  var entrarViewModel = EntrarViewModel(ocupado: false);
  var _initialValues = {'email': '', 'senha': ''};

  @override
  void dispose() {
    super.dispose();

    _senhaFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 4,
                    semanticLabel: 'Logo',
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          initialValue: _initialValues['email'],
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_senhaFocusNode),
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Por favor, informe seu email';
                            return null;
                          },
                          onSaved: (value) => entrarViewModel.email = value,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          focusNode: _senhaFocusNode,
                          decoration: const InputDecoration(labelText: 'Senha'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Por favor, informe sua senha';
                            return null;
                          },
                          onSaved: (value) => entrarViewModel.senha = value,
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  child: entrarViewModel.ocupado
                      ? SizedBox(
                          height: 15,
                          child:
                              const CircularProgressIndicator(strokeWidth: 3),
                        )
                      : Text('Entrar'),
                  elevation: 2,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.headline6.color,
                  onPressed: _entrar,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: CupertinoNavigationBar(
              middle: Text('Área Restrita'),
            ),
          )
        : Scaffold(
            key: _scaffold,
            appBar: AppBar(title: Text('Área Restrita')),
            body: body,
          );
  }

  Future _entrar() async {
    setState(() {
      entrarViewModel.ocupado = true;
    });

    final isValid = _form.currentState.validate();
    if (!isValid) return "Algum campo está inválido";

    _form.currentState.save();

    AuthResult authResult;
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: entrarViewModel.email, password: entrarViewModel.senha);
    } on PlatformException {
      _scaffold.currentState.showSnackBar(SnackBar(
        content: Text('Ocorreu um erro, verifique suas crediciais'),
      ));
    } catch (exception) {
      print(exception.message);
    }

    if (authResult?.user == null) {
      setState(() {
        entrarViewModel.ocupado = false;
      });

      return;
    }

    setState(() {
      entrarViewModel.ocupado = false;
    });

    Navigator.pushNamed(context, EditarView.routeName);
  }
}
