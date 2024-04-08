import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String titleAppBar = 'Sobre';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo_camara.png',
                height: 140,
              ),
              const Text(
                'É um aplicativo móvel projetado para oferecer aos usuários acesso fácil e conveniente a informações detalhadas sobre os deputados da Câmara dos Deputados do Brasil. Com funcionalidades como lista de deputados, detalhes individuais, atividades recentes, gastos mensais e comissões, o aplicativo proporciona uma visão abrangente do trabalho dos representantes eleitos.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Desenvolvido utilizando o framework Flutter e a linguagem de programação Dart, o Câmera dos Deputados oferece uma experiência de usuário intuitiva e eficiente, tornando mais acessível o acompanhamento das atividades parlamentares.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Desenvolvido por:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/53454609?v=4',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'RochaGabriell',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
