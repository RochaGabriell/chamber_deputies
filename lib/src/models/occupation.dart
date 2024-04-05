class OccupationModel {
  final String title;
  final String entity;
  final String entityUf;
  final String entityCountry;
  final String startYear;
  final String endYear;

  OccupationModel({
    required this.title,
    required this.entity,
    required this.entityUf,
    required this.entityCountry,
    required this.startYear,
    required this.endYear,
  });

  factory OccupationModel.fromMap(Map<String, dynamic> map) {
    return OccupationModel(
      title: map['titulo'] ?? '',
      entity: map['entidade'] ?? '',
      entityUf: map['entidadeUF'] ?? '-',
      entityCountry: map['entidadePais'] ?? '-',
      endYear: map['anoFim'].toString() == 'null' ? '-' : map['anoFim'].toString(),
      startYear: map['anoInicio'].toString() == 'null' ? '-' : map['anoInicio'].toString(),
    );
  }
}
