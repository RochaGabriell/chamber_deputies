import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:chamber_deputies/src/models/fronts.dart';
import 'package:chamber_deputies/src/repositories/deputies.dart';
import 'package:chamber_deputies/src/repositories/members_fronts.dart';
import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/stores/deputies.dart';
import 'package:chamber_deputies/src/stores/members_fronts.dart';

class ListMembersWidget extends StatefulWidget {
  final FrontsModels front;
  final Function(DeputiesModels) deputyDetailsPage;

  const ListMembersWidget({
    super.key,
    required this.front,
    required this.deputyDetailsPage,
  });

  @override
  State<ListMembersWidget> createState() => _ListMembersWidgetState();
}

class _ListMembersWidgetState extends State<ListMembersWidget> {
  late MembersStore storeMembers;
  late DeputiesStore storeDeputies;

  @override
  void initState() {
    super.initState();

    storeMembers = MembersStore(
      repository: MembersRepository(
        client: HttpClient(),
        idFront: widget.front.id,
      ),
    );
    storeMembers.getMembers();
  }

  bool _isVisible = false;

  void loadDeputyDetails(dynamic deputy) {
    storeDeputies = DeputiesStore(
      repository: DeputiesRepository(
        client: HttpClient(),
      ),
    );
    storeDeputies.getDeputyById(deputy.id).then((deputy) {
      setState(() {
        if (storeDeputies.value.value.isNotEmpty) {
          widget.deputyDetailsPage(storeDeputies.value.value.first);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Não foi possível carregar os detalhes do deputado!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final crossAxisCount = screenSize.width < 380
        ? 1
        : screenSize.width < 640
            ? 2
            : screenSize.width < 800
                ? 3
                : 4;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(254, 254, 254, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        color: const Color.fromRGBO(254, 254, 254, 1),
        child: AnimatedBuilder(
          animation: Listenable.merge(
            [
              storeMembers.isLoading,
              storeMembers.error,
              storeMembers.value,
            ],
          ),
          builder: (context, _) {
            if (storeMembers.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.amber),
                ),
              );
            }

            if (storeMembers.error.value.isNotEmpty) {
              return Center(
                child: Text(storeMembers.error.value),
              );
            }

            if (storeMembers.value.value.isEmpty) {
              return const Center(
                child: Text('Nenhum membro encontrado!'),
              );
            }

            final members = storeMembers.value.value;

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(4, 34, 116, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10),
                      bottomLeft: _isVisible
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                      bottomRight: _isVisible
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Membros da Comissão - ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Nº ${members.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: Icon(
                          _isVisible
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isVisible)
                  SizedBox(
                    height: 400,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 25,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return GestureDetector(
                            onTap: () => loadDeputyDetails(member),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(254, 254, 254, 1),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          254, 254, 254, 1),
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage(member.urlPhoto),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(86, 185, 82, 1),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          member.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  color: Colors.white,
                                                  Icons.location_on,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  member.uf,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  color: Colors.white,
                                                  Icons.group,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  member.party,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
