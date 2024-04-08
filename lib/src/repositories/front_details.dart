import 'dart:convert';

import 'package:chamber_deputies/src/models/front_details.dart';
import 'package:chamber_deputies/src/services/client.dart';

class FrontDetailsRepository {
  final HttpClient client;
  final int idFront;

  FrontDetailsRepository({
    required this.client,
    required this.idFront,
  });

  Future<FrontDetailsModels> getFrontDetails() async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/frentes/$idFront',
    );

    if (response.statusCode == 200) {
      final bodyDecode = jsonDecode(response.body);
      return FrontDetailsModels.fromMap(bodyDecode['dados']);
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
