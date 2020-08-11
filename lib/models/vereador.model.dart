import 'package:cloud_firestore/cloud_firestore.dart';

class Vereador {
  String uid;
  int ordem;
  String nome;
  String numero;
  String biografia;
  String imagem;
  String email;
  String facebook;
  String instagram;
  String twitter;
  String agenda;
  String whatsapp;
  String youtube;

  Vereador.empty() {
    this.uid = '';
    this.ordem = 0;
    this.nome = '';
    this.numero = '';
    this.biografia = '';
    this.imagem = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRZwNXnSlo6jIjFoDYoVdRtm_aOyM1HSp0TnA&usqp=CAU';
    this.email = '';
    this.facebook = '';
    this.instagram = '';
    this.twitter = '';
    this.agenda = '';
    this.whatsapp = '';
    this.youtube = '';
  }

  Vereador({
    this.uid,
    this.ordem,
    this.nome,
    this.numero,
    this.biografia,
    this.imagem,
    this.email,
    this.facebook,
    this.instagram,
    this.twitter,
    this.agenda,
    this.whatsapp,
    this.youtube,
  });

  Vereador fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Vereador.fromJson(documentSnapshot.data);
  }

  List<Vereador> fromDocumentsSnapshot(
      List<DocumentSnapshot> documentSnapshot) {
    final vereadoresDynamic = documentSnapshot.map((e) => e.data).toList();

    final vereadores = vereadoresDynamic
        .map((vereador) => Vereador.fromJson(vereador))
        .toList();

    return vereadores;
  }

  Vereador.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    ordem = json['ordem'];
    nome = json['nome'];
    numero = json['numero'];
    biografia = json['biografia'];
    imagem = json['imagem'];
    email = json['email'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    agenda = json['agenda'];
    whatsapp = json['whatsapp'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['ordem'] = this.ordem;
    data['nome'] = this.nome;
    data['numero'] = this.numero;
    data['biografia'] = this.biografia;
    data['imagem'] = this.imagem;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['agenda'] = this.agenda;
    data['whatsapp'] = this.whatsapp;
    data['youtube'] = this.youtube;
    return data;
  }
}
