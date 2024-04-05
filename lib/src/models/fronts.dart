class FrontsModels {
  final int id;
  final int idLegislature;
  final String title;
  final String uri;

  FrontsModels({
    required this.id,
    required this.idLegislature,
    required this.title,
    required this.uri,
  });

  factory FrontsModels.fromMap(Map<String, dynamic> map) {
    return FrontsModels(
      id: map['id'] ?? 0,
      idLegislature: map['idLegislatura'] ?? 0,
      title: map['titulo'] ?? '',
      uri: map['uri'] ?? '',
    );
  }
}
