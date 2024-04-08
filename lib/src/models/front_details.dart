import 'package:chamber_deputies/src/models/deputies.dart';

class FrontDetailsModels {
  final int? id;
  final int? idLegislature;
  final int? situationId;
  final String? keywords;
  final String? situation;
  final String? title;
  final String? uri;
  final String? documentUrl;
  final String? websiteUrl;
  final String? email;
  final String? phoneNumber;
  final DeputiesModels? coordinator;

  FrontDetailsModels({
    this.id,
    this.idLegislature,
    this.situationId,
    this.keywords,
    this.situation,
    this.title,
    this.uri,
    this.documentUrl,
    this.websiteUrl,
    this.email,
    this.phoneNumber,
    this.coordinator,
  });

  factory FrontDetailsModels.fromMap(Map<String, dynamic> map) {
    return FrontDetailsModels(
      id: map['id'] ?? 0,
      idLegislature: map['idLegislatura'] ?? 0,
      situationId: map['idSituacao'] ?? 0,
      keywords: map['keywords'] ?? '-',
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
