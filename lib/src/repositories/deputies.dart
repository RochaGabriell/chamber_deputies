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

  Future<List<DeputiesModels>> getDeputyById(int id) async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/deputados?id=$id',
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

  Future<List<DeputiesModels>> filterDeputies(
    String? name,
    String? uf,
    String? party,
  ) async {
    final dynamic response;
    String url = 'https://dadosabertos.camara.leg.br/api/v2/deputados?';

    url += name != null
        ? 'nome=$name'
        : uf != null
            ? 'siglaUf=$uf'
            : party != null
                ? 'siglaPartido=$party'
                : '';

    response = await client.get(url: url);

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
