import 'package:flutter/material.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';
// Routes
import 'package:chamber_deputies/src/routes/router.dart';
// Models, repositories and stores of deputies
import 'package:chamber_deputies/src/models/fronts.dart';
import 'package:chamber_deputies/src/repositories/fronts.dart';
import 'package:chamber_deputies/src/stores/fronts.dart';

class Fronts extends StatefulWidget {
  const Fronts({
    super.key,
  });

  @override
  State<Fronts> createState() => _FrontsState();
}

class _FrontsState extends State<Fronts> {
  static const String titleAppBar = 'Comissões';
  int _pageAtual = 1;

  final FrontsStore store = FrontsStore(
    repository: FrontsRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getFronts();
  }

  void frontDetailsPage(FrontsModels front) {
    Navigator.pushNamed(
      context,
      arguments: front,
      routesMap['FrontsDetails']!,
    );
  }

  void _previousPage() {
    if (_pageAtual > 1) {
      setState(() {
        _pageAtual--;
      });
      store.changePage(_pageAtual);
    }
  }

  void _nextPage() {
    if (store.value.value.isNotEmpty) {
      setState(() {
        _pageAtual++;
      });
      store.changePage(_pageAtual);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          titleAppBar,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromRGBO(254, 254, 254, 1),
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  store.isLoading,
                  store.error,
                  store.value,
                ]),
                builder: (context, _) {
                  if (store.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.amber),
                      ),
                    );
                  }

                  if (store.error.value.isNotEmpty) {
                    return Center(
                      child: Text(store.error.value),
                    );
                  }

                  if (store.value.value.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhuma comissão encontrada.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  }

                  final fronts = store.value.value;

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: fronts.length,
                    itemBuilder: (context, index) {
                      final front = fronts[index];

                      return GestureDetector(
                        onTap: () => frontDetailsPage(front),
                        child: Container(
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
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              front.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(254, 254, 254, 1),
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(86, 185, 82, 1),
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _previousPage,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(86, 185, 82, 1),
                  ),
                  child: const Text(
                    'Anterior',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Página $_pageAtual',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton(
                  onPressed: _nextPage,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(86, 185, 82, 1),
                  ),
                  child: const Text(
                    'Próximo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
