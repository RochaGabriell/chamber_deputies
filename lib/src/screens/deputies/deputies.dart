import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';
// Routes
import 'package:chamber_deputies/src/routes/router.dart';
// Models, repositories and stores of deputies
import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:chamber_deputies/src/repositories/deputies.dart';
import 'package:chamber_deputies/src/stores/deputies.dart';
// Widgets
import 'package:chamber_deputies/src/screens/deputies/widgets/list_deputies_widget.dart';

class Deputies extends StatefulWidget {
  const Deputies({
    super.key,
  });

  @override
  State<Deputies> createState() => _DeputiesState();
}

class _DeputiesState extends State<Deputies> {
  static const String titleAppBar = 'Deputados';
  final Map<String, String> options = {
    'siglaPartido': 'Partido',
    'siglaUf': 'UF',
    'nome': 'Nome',
  };
  String _selectedOption = '';
  String search = '';

  final DeputiesStore store = DeputiesStore(
    repository: DeputiesRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getDeputies();
  }

  void deputyDetailsPage(DeputiesModels deputy) {
    Navigator.pushNamed(
      context,
      arguments: deputy,
      routesMap['DeputyDetails']!,
    );
  }

  void _setSelectedOption(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  void filterDeputies() {
    switch (_selectedOption) {
      case 'siglaPartido':
        store.filterDeputies(null, null, search).then((value) {
          setState(() {});
        });
      case 'siglaUf':
        store.filterDeputies(null, search, null).then((value) {
          setState(() {});
        });
      case 'nome':
        store.filterDeputies(search, null, null).then((value) {
          setState(() {});
        });
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_selectedOption.isNotEmpty)
                  SizedBox(
                    width: _selectedOption.isEmpty
                        ? MediaQuery.of(context).size.width * 0.1
                        : MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      children: [
                        SizedBox(
                          width: _selectedOption.isEmpty
                              ? MediaQuery.of(context).size.width * 0.1
                              : MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  'Pesquisar por ${options[_selectedOption]}',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(86, 185, 82, 1)),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                search = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(
                                  86, 185, 82, 1), // Cor de fundo do botão
                              shape: BoxShape.circle, // Forma do botão
                            ),
                            child: IconButton(
                              onPressed: () => filterDeputies(),
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white, // Cor do ícone
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                if (_selectedOption.isNotEmpty) const Spacer(),
                Container(
                  width: _selectedOption.isEmpty
                      ? MediaQuery.of(context).size.width - 20
                      : MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(86, 185, 82, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!_selectedOption.isNotEmpty)
                          const Text(
                            'Filtrar por:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        if (!_selectedOption.isNotEmpty) const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showCupertinoModalPopup(
                              barrierColor: Colors.black.withOpacity(0.5),
                              context: context,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  title: const Text(
                                    'Filtrar por:',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  actions: options.entries
                                      .map(
                                        (entry) => CupertinoActionSheetAction(
                                          onPressed: () {
                                            _setSelectedOption(entry.key);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            entry.value,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
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
                      'Nenhum deputado encontrado.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final deputies = store.value.value;

                return ListDeputiesWidget(
                  deputies: deputies,
                  deputyDetailsPage: deputyDetailsPage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
