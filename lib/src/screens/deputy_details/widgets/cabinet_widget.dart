import 'package:flutter/material.dart';

// Models Deputies
import 'package:chamber_deputies/src/models/deputies.dart';
// Models for Deputy Details
import 'package:chamber_deputies/src/models/deputy_details.dart';

class CabinetWidget extends StatefulWidget {
  final DeputiesModels deputy;
  final DeputyDetailsModel deputyDetails;

  const CabinetWidget({
    super.key,
    required this.deputy,
    required this.deputyDetails,
  });

  @override
  State<CabinetWidget> createState() => _CabinetWidgetState();
}

class _CabinetWidgetState extends State<CabinetWidget> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
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
                  'Gabinete',
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
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final cabinet in widget.deputyDetails.cabinet!.entries)
                    cabinet.key == 'email'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cabinet.key[0].toUpperCase() + cabinet.key.substring(1)}: ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                cabinet.value ?? '-',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                '${cabinet.key[0].toUpperCase() + cabinet.key.substring(1)}: ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                cabinet.value ?? '-',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
