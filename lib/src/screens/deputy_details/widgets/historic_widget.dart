import 'package:flutter/material.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';
// Models of Deputies
import 'package:chamber_deputies/src/models/deputies.dart';
// Models, Repositories and Services of Historic
import 'package:chamber_deputies/src/repositories/historic.dart';
import 'package:chamber_deputies/src/stores/historic.dart';

class HistoricWidget extends StatefulWidget {
  final DeputiesModels deputy;

  const HistoricWidget({
    super.key,
    required this.deputy,
  });

  @override
  State<HistoricWidget> createState() => _HistoricWidgetState();
}

class _HistoricWidgetState extends State<HistoricWidget> {
  late HistoricStore storeHistoric;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    storeHistoric = HistoricStore(
      repository: HistoricRepository(
        client: HttpClient(),
        idDeputy: widget.deputy.id,
      ),
    );
    storeHistoric.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final historic = storeHistoric.value.value;

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
      child: Column(
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
                  'Histórico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
                    _isVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (_isVisible)
            SizedBox(
              height: 300,
              child: AnimatedBuilder(
                animation: Listenable.merge(
                  [
                    storeHistoric.error,
                    storeHistoric.isLoading,
                    storeHistoric.value,
                  ],
                ),
                builder: (context, _) {
                  if (storeHistoric.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.amber),
                      ),
                    );
                  }

                  if (storeHistoric.error.value.isNotEmpty) {
                    return Center(
                      child: Text(storeHistoric.error.value),
                    );
                  }

                  if (storeHistoric.value.value.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhum dado encontrado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: historic.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final situation = historic[index];

                      return Container(
                        width: 350,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Partido: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  situation.party,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Condição: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  situation.electoralCondition,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Descrição:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              situation.statusDescription,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
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
