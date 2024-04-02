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

  Future<List<ExpenseModel>> getExpensesById() async {
    final response = await client.get(
      url:
          'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/despesas',
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

  Future<List<ExpenseModel>> getExpensesByMonthYear(
      int? month, int? year) async {
    final dynamic response;

    if (month != null && year == null) {
      response = await client.get(
        url:
            'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/despesas?mes=$month',
      );
    } else if (month == null && year != null) {
      response = await client.get(
        url:
            'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/despesas?ano=$year',
      );
    } else {
      response = await client.get(
        url:
            'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy/despesas?mes=$month&ano=$year',
      );
    }

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
