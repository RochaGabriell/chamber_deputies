import 'package:chamber_deputies/src/repositories/occupation.dart';
import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/stores/occupation.dart';
import 'package:flutter/material.dart';

// Models for Deputies
import 'package:chamber_deputies/src/models/deputies.dart';

class OccupationsWidget extends StatefulWidget {
  final DeputiesModels deputy;

  const OccupationsWidget({
    super.key,
    required this.deputy,
  });

  @override
  State<OccupationsWidget> createState() => _OccupationsWidgetState();
}

class _OccupationsWidgetState extends State<OccupationsWidget> {
  late OccupationsStore storeOccupations;

  @override
  void initState() {
    super.initState();

    storeOccupations = OccupationsStore(
      repository: OccupationsRepository(
        client: HttpClient(),
        idDeputy: widget.deputy.id,
      ),
    );
    storeOccupations.getOccupations().then((occupations) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(86, 185, 82, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Ocupações do Deputado',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          SizedBox(
            height: 250,
            child: AnimatedBuilder(
              animation: Listenable.merge(
                [
                  storeOccupations.error,
                  storeOccupations.isLoading,
                  storeOccupations.value,
                ],
              ),
              builder: (context, _) {
                if (storeOccupations.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.amber),
                    ),
                  );
                }

                if (storeOccupations.error.value.isNotEmpty) {
                  return Center(
                    child: Text(storeOccupations.error.value),
                  );
                }

                if (storeOccupations.value.value.first.title == '') {
                  return const Center(
                    child: Text(
                      'Nenhuma ocupação encontrada',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                final occupations = storeOccupations.value.value;

                return ListView.builder(
                  itemCount: occupations.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final occupation = occupations[index];
                    return Container(
                      width: 350,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'UF/País',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${occupation.entityUf}/${occupation.entityCountry}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Color.fromRGBO(22, 49, 21, 1),
                            thickness: 1,
                          ),
                          const Text(
                            'Ocupação',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            occupation.title,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Entidade',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            occupation.entity,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                'Ano de início',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                occupation.startYear,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'Ano de fim',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                occupation.endYear,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
