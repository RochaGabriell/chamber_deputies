import 'package:flutter/material.dart';

class Commission extends StatefulWidget {
  const Commission({
    super.key,
  });

  @override
  State<Commission> createState() => _CommissionState();
}

class _CommissionState extends State<Commission> {
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
