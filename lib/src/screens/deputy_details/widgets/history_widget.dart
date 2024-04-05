import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatefulWidget {
  final DeputiesModels deputy;

  const HistoryWidget({
    super.key,
    required this.deputy,
  });

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
      child: const Column(
        children: [
          Text(
            'Histórico do Deputado',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
