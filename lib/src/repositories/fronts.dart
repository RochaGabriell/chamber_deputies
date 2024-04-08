import 'dart:convert';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/fronts.dart';

class FrontsRepository {
  final HttpClient client;

  FrontsRepository({
    required this.client,
  });

  Future<List<FrontsModels>> getFronts() async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/frentes?itens=100',
    );

    if (response.statusCode == 200) {
      final List<FrontsModels> fronts = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((front) {
        fronts.add(FrontsModels.fromMap(front));
      }).toList();

      return fronts;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }

  Future<List<FrontsModels>> changePage(int page) async {
    final response = await client.get(
      url:
          'https://dadosabertos.camara.leg.br/api/v2/frentes?itens=100&pagina=$page',
    );

    if (response.statusCode == 200) {
      final List<FrontsModels> fronts = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((front) {
        fronts.add(FrontsModels.fromMap(front));
      }).toList();

      return fronts;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
