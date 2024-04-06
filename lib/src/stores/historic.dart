import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/repositories/historic.dart';
import 'package:chamber_deputies/src/models/historic.dart';

class HistoricStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<HistoricModels>> value =
      ValueNotifier<List<HistoricModels>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final HistoricRepository repository;

  HistoricStore({
    required this.repository,
  });

  Future getExpenses() async {
    isLoading.value = true;

    try {
      final result = await repository.getHistoric();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
