import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/models/members_front.dart';
import 'package:chamber_deputies/src/repositories/members_fronts.dart';

class MembersStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<MembersFrontModels>> value =
      ValueNotifier<List<MembersFrontModels>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  final MembersRepository repository;

  MembersStore({
    required this.repository,
  });

  Future getMembers() async {
    isLoading.value = true;

    try {
      final result = await repository.getMembers();
      value.value = result;
    } on Exception catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
