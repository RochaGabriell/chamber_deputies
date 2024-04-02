import 'dart:convert';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/deputies.dart';

class DeputiesRepository {
  final HttpClient client;

  DeputiesRepository({
    required this.client,
  });

  Future<List<DeputiesModels>> getDeputies() async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/deputados',
    );

    if (response.statusCode == 200) {
      final List<DeputiesModels> deputies = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((deputy) {
        deputies.add(DeputiesModels.fromMap(deputy));
      }).toList();

      return deputies;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
