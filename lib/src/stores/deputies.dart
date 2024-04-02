import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/repositories/deputies.dart';
import 'package:chamber_deputies/src/models/deputies.dart';

class DeputiesStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<DeputiesModels>> value =
      ValueNotifier<List<DeputiesModels>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final DeputiesRepository repository;

  DeputiesStore({
    required this.repository,
  });

  Future getDeputies() async {
    isLoading.value = true;

    try {
      final result = await repository.getDeputies();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
