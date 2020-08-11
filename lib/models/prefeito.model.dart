import 'package:PGP2020/models/imagens.model.dart';
import 'package:PGP2020/models/plano_governo.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Prefeito {
  String uid;
  String email;
  String facebook;
  Imagens imagens;
  String instagram;
  String nome;
  List<PlanoGoverno> planoGoverno;
  List<String> agenda;
  String twitter;
  String whatsapp;
  String youtube;

  Prefeito.empty() {
    this.uid = '';
    this.email = '';
    this.facebook = '';
    this.imagens = Imagens.empty();
    this.instagram = '';
    this.nome = '';
    this.planoGoverno = [PlanoGoverno.empty()];
    this.twitter = '';
    this.whatsapp = '';
    this.youtube = '';
  }

  Prefeito({
    this.uid,
    this.email,
    this.facebook,
    this.imagens,
    this.instagram,
    this.nome,
    this.planoGoverno,
    this.twitter,
    this.whatsapp,
    this.youtube,
  });

  Prefeito fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Prefeito.fromJson(documentSnapshot.data);
  }

  List<Prefeito> fromDocumentsSnapshot(
      List<DocumentSnapshot> documentSnapshot) {
    final vereadoresDynamic = documentSnapshot.map((e) => e.data).toList();

    final vereadores = vereadoresDynamic
        .map((vereador) => Prefeito.fromJson(vereador))
        .toList();

    return vereadores;
  }

  Prefeito.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    facebook = json['facebook'];
    imagens =
        json['imagens'] != null ? new Imagens.fromJson(json['imagens']) : null;
    instagram = json['instagram'];
    nome = json['nome'];
    if (json['planoGoverno'] != null) {
      planoGoverno = List<PlanoGoverno>();
      json['planoGoverno'].forEach((v) {
        planoGoverno.add(new PlanoGoverno.fromJson(v));
      });
    }
    agenda = json['agenda'].cast<String>();
    twitter = json['twitter'];
    whatsapp = json['whatsapp'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    if (this.imagens != null) {
      data['imagens'] = this.imagens.toJson();
    }
    data['instagram'] = this.instagram;
    data['nome'] = this.nome;
    if (this.planoGoverno != null) {
      data['planoGoverno'] = this.planoGoverno.map((v) => v.toJson()).toList();
    }
    data['agenda'] = this.agenda;
    data['twitter'] = this.twitter;
    data['whatsapp'] = this.whatsapp;
    data['youtube'] = this.youtube;
    return data;
  }
}
