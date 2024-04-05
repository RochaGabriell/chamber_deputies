class HistoricModels {
  final int id;
  final String uri;
  final String name;
  final String party;
  final String uf;
  final int idLegislature;
  final String urlPhoto;
  final String email;
  final String electoralCondition;
  final String dateTime;
  final String statusDescription;
  final String electoralName;
  final String partyAbbreviation;
  final String situation;
  final String partyUri;

  HistoricModels({
    required this.id,
    required this.uri,
    required this.name,
    required this.party,
    required this.uf,
    required this.idLegislature,
    required this.urlPhoto,
    required this.email,
    required this.electoralCondition,
    required this.dateTime,
    required this.statusDescription,
    required this.electoralName,
    required this.partyAbbreviation,
    required this.situation,
    required this.partyUri,
  });

  factory HistoricModels.fromMap(Map<String, dynamic> map) {
    return HistoricModels(
      id: map['id'] ?? 0,
      uri: map['uri'] ?? '',
      name: map['nome'] ?? '',
      party: map['siglaPartido'] ?? '',
      uf: map['siglaUf'] ?? '',
      idLegislature: map['idLegislatura'] ?? 0,
      urlPhoto: map['urlFoto'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      email: map['email'] ?? '',
      electoralCondition: map['condicaoEleitoral'] ?? '',
      dateTime: map['dataHora'] ?? '',
      statusDescription: map['descricaoStatus'] ?? '',
      electoralName: map['nomeEleitoral'] ?? '',
      partyAbbreviation: map['siglaPartido'] ?? '',
      situation: map['situacao'] ?? '',
      partyUri: map['uriPartido'] ?? '',
    );
  }
}
