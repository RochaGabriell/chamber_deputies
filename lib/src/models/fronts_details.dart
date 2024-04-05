class FrontsDetailsModels {
  final int id;
  final int idLegislature;
  final int situationId;
  final String keywords;
  final String situation;
  final String title;
  final String uri;
  final String documentUrl;
  final String websiteUrl;
  final String email;
  final String phoneNumber;
  final Coordinator coordinator;

  FrontsDetailsModels({
    required this.id,
    required this.idLegislature,
    required this.situationId,
    required this.keywords,
    required this.situation,
    required this.title,
    required this.uri,
    required this.documentUrl,
    required this.websiteUrl,
    required this.email,
    required this.phoneNumber,
    required this.coordinator,
  });

  factory FrontsDetailsModels.fromMap(Map<String, dynamic> map) {
    return FrontsDetailsModels(
      id: map['id'] ?? 0,
      idLegislature: map['idLegislatura'] ?? 0,
      situationId: map['idSituacao'] ?? 0,
      keywords: map['keywords'] ?? '',
      situation: map['situacao'] ?? '',
      title: map['titulo'] ?? '',
      uri: map['uri'] ?? '',
      documentUrl: map['urlDocumento'] ?? '',
      websiteUrl: map['urlWebsite'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['telefone'] ?? '',
      coordinator: Coordinator.fromMap(map['coordenador'] ?? {}),
    );
  }
}

class Coordinator {
  final int id;
  final int idLegislature;
  final String name;
  final String partyAbbreviation;
  final String uf;
  final String uri;
  final String partyUri;
  final String photoUrl;
  final String email;

  Coordinator({
    required this.id,
    required this.idLegislature,
    required this.name,
    required this.partyAbbreviation,
    required this.uf,
    required this.uri,
    required this.partyUri,
    required this.photoUrl,
    required this.email,
  });

  factory Coordinator.fromMap(Map<String, dynamic> map) {
    return Coordinator(
      id: map['id'] ?? 0,
      idLegislature: map['idLegislatura'] ?? 0,
      name: map['nome'] ?? '',
      partyAbbreviation: map['siglaPartido'] ?? '',
      uf: map['siglaUf'] ?? '',
      uri: map['uri'] ?? '',
      partyUri: map['uriPartido'] ?? '',
      photoUrl: map['urlFoto'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
