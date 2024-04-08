import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/models/deputies.dart';

class ListDeputiesWidget extends StatefulWidget {
  final List<DeputiesModels> deputies;
  final Function(DeputiesModels) deputyDetailsPage;

  const ListDeputiesWidget({
    super.key,
    required this.deputies,
    required this.deputyDetailsPage,
  });

  @override
  State<ListDeputiesWidget> createState() => _ListDeputiesWidgetState();
}

class _ListDeputiesWidgetState extends State<ListDeputiesWidget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final crossAxisCount = screenSize.width < 380
        ? 1
        : screenSize.width < 640
            ? 2
            : screenSize.width < 800
                ? 3
                : 4;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 25,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.deputies.length,
      itemBuilder: (context, index) {
        final deputy = widget.deputies[index];
        return GestureDetector(
          onTap: () => widget.deputyDetailsPage(deputy),
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(254, 254, 254, 1),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(deputy.urlPhoto),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(86, 185, 82, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        deputy.name,
                        overflow: TextOverflow.ellipsis,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
