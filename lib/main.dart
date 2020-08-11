import 'dart:async';

import 'package:PGP2020/views/agenda.view.dart';
import 'package:PGP2020/views/editar.view.dart';
import 'package:PGP2020/views/entrar.view.dart';
import 'package:PGP2020/views/home.view.dart';
import 'package:PGP2020/views/obras.view.dart';
import 'package:PGP2020/views/perfil.view.dart';
import 'package:PGP2020/views/plano_governo.view.dart';
import 'package:PGP2020/views/plano_governo_details.view.dart';
import 'package:PGP2020/views/projetos.view.dart';
import 'package:PGP2020/views/realizacoes.view.dart';
import 'package:PGP2020/views/topicos/educacao.view.dart';
import 'package:PGP2020/views/topicos/mobilidade.view.dart';
import 'package:PGP2020/views/topicos/saude.view.dart';
import 'package:PGP2020/views/topicos/social.view.dart';
import 'package:PGP2020/views/vereadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart';

void main() {
  final SentryClient sentry = new SentryClient(
      dsn:
          "https://d20884c998b54bb096e429dfa579e1bf@o340240.ingest.sentry.io/5387006");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // Run the whole app in a zone to capture all uncaught errors.
    runZoned(
      () => runApp(MyApp()),
      onError: (Object error, StackTrace stackTrace) {
        try {
          sentry.captureException(
            exception: error,
            stackTrace: stackTrace,
          );
          print('Error sent to sentry.io: $error');
        } catch (e) {
          print('Sending report to sentry.io failed: $e');
          print('Original error: $error');
        }
      },
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.grey[300],
        accentColor: Colors.white,
        buttonColor: Colors.red[700],
        // fontFamily: 'RobotoCondensed',
        // textTheme: ThemeData.light().textTheme.copyWith(
        // ),
        buttonTheme: ButtonTheme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.red[700],
          ),
          buttonColor: Colors.red[700],
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        HomeView.routeName: (ctx) => HomeView(),
        ObrasView.routeName: (ctx) => ObrasView(),
        RealizacoesView.routeName: (ctx) => RealizacoesView(),
        ProjetosView.routeName: (ctx) => ProjetosView(),
        PlanoGovernoView.routeName: (ctx) => PlanoGovernoView(),
        PlanoGovernoDetailsView.routeName: (ctx) => PlanoGovernoDetailsView(),
        VereadoresView.routeName: (ctx) => VereadoresView(),
        EducacaoView.routeName: (ctx) => EducacaoView(),
        SaudeView.routeName: (ctx) => SaudeView(),
        SocialView.routeName: (ctx) => SocialView(),
        MobilidadeView.routeName: (ctx) => MobilidadeView(),
        AgendaView.routeName: (ctx) => AgendaView(),
        PerfilView.routeName: (ctx) => PerfilView(),
        EntrarView.routeName: (ctx) => EntrarView(),
        EditarView.routeName: (ctx) => EditarView(),
      },
      onGenerateRoute: (settings) {
        // print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => HomeView(),
        );
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => HomeView(),
      ),
    );
  }
}
