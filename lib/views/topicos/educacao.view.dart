import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducacaoView extends StatefulWidget {
  static const routeName = "/educacao";

  @override
  _EducacaoViewState createState() => _EducacaoViewState();
}

class _EducacaoViewState extends State<EducacaoView> {
  final _form = GlobalKey<FormState>();

  final _mensagemFocusNode = FocusNode();

  String _nome;
  String _mensagem;
  String _email = 'taciodesouzacampos@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_mensagemFocusNode),
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value.isEmpty) return 'Por favor, informe seu nome';
                  return null;
                },
                onSaved: (value) => _nome = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_mensagemFocusNode),
                decoration: const InputDecoration(labelText: 'Mensagem'),
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: null,
                validator: (value) {
                  if (value.isEmpty) return 'Por favor, informe a mensagem';
                  return null;
                },
                onSaved: (value) => _mensagem = value,
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: const Text('Enviar'),
                onPressed: _launchEmail,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchEmail() {
    _form.currentState.validate();
    _form.currentState.save();

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: _email,
        queryParameters: {
          'subject': 'PGP2020 - Educação',
          'body': 'Nome: $_nome\n\n$_mensagem'
        });

    // mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
    launch(_emailLaunchUri.toString());
  }
}
