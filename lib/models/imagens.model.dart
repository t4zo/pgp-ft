class Imagens {
  String home;
  String agenda;
  String planoGoverno;
  String vereadores;

  Imagens({this.home, this.agenda, this.planoGoverno, this.vereadores});

  Imagens.empty() {
    this.home = '';
    this.agenda = '';
    this.planoGoverno = '';
    this.vereadores = '';
  }

  Imagens.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    agenda = json['agenda'];
    planoGoverno = json['planoGoverno'];
    vereadores = json['vereadores'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['home'] = this.home;
    data['agenda'] = this.agenda;
    data['planoGoverno'] = this.planoGoverno;
    data['vereadores'] = this.vereadores;
    return data;
  }
}