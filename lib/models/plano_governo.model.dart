class PlanoGoverno {
  int id;
  String nome;
  String descricao;

  PlanoGoverno({this.id, this.nome, this.descricao});

  PlanoGoverno.empty() {
    id = 0;
    nome = '';
    descricao = '';
  }

  PlanoGoverno.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    return data;
  }
}