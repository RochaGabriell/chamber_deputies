import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/routes/router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String titleAppBar = 'Início';

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
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Image.asset(
                'assets/images/logo_camara.png',
                height: 140,
              ),
            ),
            GridView.count(
              padding: const EdgeInsets.all(10.0),
              // Cria duas Colunas. E se eu mudar a scrollDirection vira duas linhas.
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // desativar a rolagem do GridView
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true, // Você não verá erro de tamanho infinito
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(86, 185, 82, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, routesMap['Deputies']!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/deputy_icon.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Deputados',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(254, 254, 254, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(86, 185, 82, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, routesMap['Comissions']!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/commission_icon.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Comissões',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(254, 254, 254, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(86, 185, 82, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, routesMap['Home']!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/information_icon.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Sobre',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(254, 254, 254, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
