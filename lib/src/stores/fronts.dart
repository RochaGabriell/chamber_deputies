import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/repositories/fronts.dart';
import 'package:chamber_deputies/src/models/fronts.dart';

class FrontsStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<FrontsModels>> value =
      ValueNotifier<List<FrontsModels>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final FrontsRepository repository;

  FrontsStore({
    required this.repository,
  });

  Future getFronts() async {
    isLoading.value = true;

    try {
      final result = await repository.getFronts();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future changePage(int page) async {
    isLoading.value = true;

    try {
      final result = await repository.changePage(page);
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
