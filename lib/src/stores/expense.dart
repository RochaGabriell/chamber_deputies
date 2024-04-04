import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/repositories/expense.dart';
import 'package:chamber_deputies/src/models/expense.dart';

class ExpenseStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<ExpenseModel>> value =
      ValueNotifier<List<ExpenseModel>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ExpenseRepository repository;

  ExpenseStore({
    required this.repository,
  });

  Future getExpenses() async {
    isLoading.value = true;

    try {
      final result = await repository.getExpensesById();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future getExpensesByMonthYear(int month, int year) async {
    isLoading.value = true;

    try {
      final result = await repository.getExpensesByMonthYear(month, year);
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
