import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/models/occupation.dart';
import 'package:chamber_deputies/src/repositories/occupation.dart';

class OccupationsStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<OccupationModel>> value =
      ValueNotifier<List<OccupationModel>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final OccupationsRepository repository;

  OccupationsStore({
    required this.repository,
  });

  Future getOccupations() async {
    isLoading.value = true;

    try {
      final result = await repository.getOccupations();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
