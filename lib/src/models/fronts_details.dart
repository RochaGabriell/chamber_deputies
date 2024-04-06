import 'package:chamber_deputies/src/models/deputies.dart';

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
  final DeputiesModels coordinator;

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
      coordinator: DeputiesModels.fromMap(map['coordenador'] ?? {}),
    );
  }
}
