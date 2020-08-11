import 'package:PGP2020/constants.dart';
import 'package:PGP2020/models/prefeito.model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgendaView extends StatefulWidget {
  static const routeName = '/agenda';

  @override
  _AgendaViewState createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Firestore.instance
                .collection(Constants.PREFEITO)
                .getDocuments(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final querySnapshot = snapshot.data as QuerySnapshot;
              final prefeito = Prefeito().fromDocumentsSnapshot(querySnapshot.documents).first;
              return Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Agenda',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CarouselSlider(
                        options: CarouselOptions(height: 400.0),
                        items: prefeito.agenda.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Center(
                                    child: Image.network(image),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
