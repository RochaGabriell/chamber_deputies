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

  List<DeputiesModels> filterDeputies(List<DeputiesModels> deputies) {
    if (search.isEmpty) {
      return deputies;
    }

    return deputies
        .where((deputy) =>
            deputy.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
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
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar',
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Color.fromRGBO(86, 185, 82, 1)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
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
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
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
                                          fontSize: 14,
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
