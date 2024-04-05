import 'package:flutter/material.dart';

class Fronts extends StatefulWidget {
  const Fronts({
    super.key,
  });

  @override
  State<Fronts> createState() => _FrontsState();
}

class _FrontsState extends State<Fronts> {
  static const String titleAppBar = 'Comissões';

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
      body: const Center(
        child: Text('Olá! 👋'),
      ),
    );
  }
}
