import 'dart:convert';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/expense.dart';

class ExpenseRepository {
  final HttpClient client;
  final int idDeputy;

  ExpenseRepository({
    required this.client,
    required this.idDeputy,
  });

  Future<List<ExpenseModel>> getExpenses() async {
    final response = await client.get(
      url:
          'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/despesas?ano=2024&itens=100',
    );

    if (response.statusCode == 200) {
      final List<ExpenseModel> expenses = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((expense) {
        expenses.add(ExpenseModel.fromMap(expense));
      }).toList();

      return expenses;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }

  Future<List<ExpenseModel>> getExpensesByMonthYear(int month, int year) async {
    final dynamic response;

    String url =
        'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/despesas';

    url += '${month != 0 ? '?mes=$month&' : '?'}ano=$year&itens=100';

    response = await client.get(url: url);

    if (response.statusCode == 200) {
      final List<ExpenseModel> expenses = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((expense) {
        expenses.add(ExpenseModel.fromMap(expense));
      }).toList();

      return expenses;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
