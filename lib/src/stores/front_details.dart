import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/models/front_details.dart';
import 'package:chamber_deputies/src/repositories/front_details.dart';

class FrontDetailsStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<FrontDetailsModels> value =
      ValueNotifier<FrontDetailsModels>(FrontDetailsModels());
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final FrontDetailsRepository repository;

  FrontDetailsStore({
    required this.repository,
  });

  Future getFrontDetails() async {
    isLoading.value = true;

    try {
      final result = await repository.getFrontDetails();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
