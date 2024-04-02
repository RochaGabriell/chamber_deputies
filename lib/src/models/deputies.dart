class DeputiesModels {
  final int id;
  final String uri;
  final String name;
  final String party;
  final String uf;
  final int idLegislature;
  final String urlPhoto;
  final String email;

  DeputiesModels({
    required this.id,
    required this.uri,
    required this.name,
    required this.party,
    required this.uf,
    required this.idLegislature,
    required this.urlPhoto,
    required this.email,
  });

  factory DeputiesModels.fromMap(Map<String, dynamic> map) {
    return DeputiesModels(
      id: map['id'] ?? 0,
      uri: map['uri'] ?? '',
      name: map['nome'] ?? '',
      party: map['siglaPartido'] ?? '',
      uf: map['siglaUf'] ?? '',
      idLegislature: map['idLegislatura'] ?? 0,
      urlPhoto: map['urlFoto'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      email: map['email'] ?? '',
    );
  }
}
