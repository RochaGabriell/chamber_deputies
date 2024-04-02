class DeputyDetailsModel {
  final String? name;
  final String? civilName;
  final String? situation;
  final String? condition;
  final String? status;
  final String? cpf;
  final String? sex;
  final String? website;
  final List<dynamic>? socialMedia;
  final String? birthDate;
  final String? deathDate;
  final String? birthUf;
  final String? birthCity;
  final String? education;
  final Map<String, dynamic>? cabinet;

  DeputyDetailsModel({
    this.name,
    this.civilName,
    this.situation,
    this.condition,
    this.status,
    this.cpf,
    this.sex,
    this.website,
    this.socialMedia,
    this.birthDate,
    this.deathDate,
    this.birthUf,
    this.birthCity,
    this.education,
    this.cabinet,
  });

  factory DeputyDetailsModel.fromMap(Map<String, dynamic> map) {
    return DeputyDetailsModel(
      name: map['ultimoStatus']['nomeEleitoral'] ?? '',
      civilName: map['nomeCivil'] ?? '',
      situation: map['ultimoStatus']['situacao'] ?? '',
      condition: map['ultimoStatus']['condicaoEleitoral'] ?? '',
      status: map['ultimoStatus']['descricaoStatus'] ?? '',
      cpf: map['cpf'] ?? '',
      sex: map['sexo'] ?? '',
      website: map['urlWebsite'] ?? '',
      socialMedia: map['redeSocial'] ?? [],
      birthDate: map['dataNascimento'] ?? '',
      deathDate: map['dataFalecimento'] ?? '',
      birthUf: map['ufNascimento'] ?? '',
      birthCity: map['municipioNascimento'] ?? '',
      education: map['escolaridade'] ?? '',
      cabinet: map['ultimoStatus']['gabinete'] ?? {},
    );
  }
}
