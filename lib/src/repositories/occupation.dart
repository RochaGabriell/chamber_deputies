import 'dart:convert';

import 'package:chamber_deputies/src/models/occupation.dart';
import 'package:chamber_deputies/src/services/client.dart';

class OccupationsRepository {
  final HttpClient client;
  final int idDeputy;

  OccupationsRepository({
    required this.client,
    required this.idDeputy,
  });

  Future<List<OccupationModel>> getOccupations() async {
    final response = await client.get(
      url:
          'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/ocupacoes',
    );

    if (response.statusCode == 200) {
      final List<OccupationModel> occupations = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((occupation) {
        occupations.add(OccupationModel.fromMap(occupation));
      }).toList();

      return occupations;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
