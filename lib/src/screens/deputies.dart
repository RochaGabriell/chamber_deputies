import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/routes/router.dart';
import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/repositories/deputies.dart';
import 'package:chamber_deputies/src/stores/deputies.dart';

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

  List<DeputiesModels> filterDeputies(List<DeputiesModels> deputies) {
    switch (_selectedOption) {
      case 'siglaPartido':
        return deputies.where((deputy) {
          return deputy.party.toLowerCase().contains(search.toLowerCase());
        }).toList();
      case 'siglaUf':
        return deputies.where((deputy) {
          return deputy.uf.toLowerCase().contains(search.toLowerCase());
        }).toList();
      case 'nome':
        return deputies.where((deputy) {
          return deputy.name.toLowerCase().contains(search.toLowerCase());
        }).toList();
      default:
        return deputies;
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
      body: Container(
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
                child: Text('Nenhum deputado encontrado.'),
              );
            }

            final deputies = filterDeputies(store.value.value);

            return Column(
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
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  'Pesquisar por ${options[_selectedOption]}',
                              prefixIcon: const Icon(Icons.search),
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
                      Container(
                        width: _selectedOption.isEmpty
                            ? MediaQuery.of(context).size.width * 0.8
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
                                    context: context,
                                    builder: (context) {
                                      return CupertinoActionSheet(
                                        title: const Text('Filtrar por:'),
                                        actions: options.entries
                                            .map(
                                              (entry) =>
                                                  CupertinoActionSheetAction(
                                                onPressed: () {
                                                  _setSelectedOption(entry.key);
                                                  Navigator.pop(context);
                                                },
                                                child: Text(entry.value),
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
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: deputies.length,
                    itemBuilder: (context, index) {
                      final deputy = deputies[index];
                      return GestureDetector(
                        onTap: () => deputyDetailsPage(deputy),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(deputy.urlPhoto),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                deputy.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        color: Colors.white,
                                        Icons.location_on,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        deputy.uf,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        color: Colors.white,
                                        Icons.group,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        deputy.party,
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
                      );
                    },
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
