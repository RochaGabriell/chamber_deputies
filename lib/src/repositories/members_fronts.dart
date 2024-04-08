import 'dart:convert';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/members_front.dart';

class MembersRepository {
  final HttpClient client;
  final int idFront;

  MembersRepository({
    required this.client,
    required this.idFront,
  });

  Future<List<MembersFrontModels>> getMembers() async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/frentes/$idFront/membros',
    );

    if (response.statusCode == 200) {
      final List<MembersFrontModels> members = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((member) {
        members.add(MembersFrontModels.fromMap(member));
      }).toList();

      return members;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
