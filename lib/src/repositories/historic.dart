import 'dart:convert';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/historic.dart';

class HistoricRepository {
  final HttpClient client;
  final int idDeputy;

  HistoricRepository({
    required this.client,
    required this.idDeputy,
  });

  Future<List<HistoricModels>> getHistoric() async {
    final response = await client.get(
      url:
          'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/historico',
    );

    if (response.statusCode == 200) {
      final List<HistoricModels> expenses = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((expense) {
        expenses.add(HistoricModels.fromMap(expense));
      }).toList();

      return expenses;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
