import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/models/deputy_details.dart';
import 'package:chamber_deputies/src/repositories/deputy_detail.dart';

class DeputyDetailsStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<DeputyDetailsModel> value =
      ValueNotifier<DeputyDetailsModel>(DeputyDetailsModel());
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final DeputyDetailsRepository repository;

  DeputyDetailsStore({
    required this.repository,
  });

  Future getDeputyDetails() async {
    isLoading.value = true;

    try {
      final result = await repository.getDeputyDetails();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
