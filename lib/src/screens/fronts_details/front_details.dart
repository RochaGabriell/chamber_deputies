import 'package:flutter/material.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';
// Routes
import 'package:chamber_deputies/src/routes/router.dart';
// Models of fronts
import 'package:chamber_deputies/src/models/fronts.dart';
// Repository and store of fronts details
import 'package:chamber_deputies/src/repositories/front_details.dart';
import 'package:chamber_deputies/src/stores/front_details.dart';
// Models of deputies
import 'package:chamber_deputies/src/models/deputies.dart';
// Widgets
import 'package:chamber_deputies/src/screens/fronts_details/widgets/information_widget.dart';
import 'package:chamber_deputies/src/screens/fronts_details/widgets/list_members_widget.dart';

class FrontDetails extends StatefulWidget {
  final FrontsModels front;

  const FrontDetails({
    super.key,
    required this.front,
  });

  @override
  State<FrontDetails> createState() => _FrontsDetailsState();
}

class _FrontsDetailsState extends State<FrontDetails> {
  static const String titleAppBar = 'Detalhes da Comissão';
  late FrontDetailsStore storeFrontDetails;

  @override
  void initState() {
    super.initState();

    storeFrontDetails = FrontDetailsStore(
      repository: FrontDetailsRepository(
        client: HttpClient(),
        idFront: widget.front.id,
      ),
    );
    storeFrontDetails.getFrontDetails();
  }

  void deputyDetailsPage(DeputiesModels deputy) {
    Navigator.pushNamed(
      context,
      arguments: deputy,
      routesMap['DeputyDetails']!,
    );
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
          animation: Listenable.merge(
            [
              storeFrontDetails.isLoading,
              storeFrontDetails.error,
              storeFrontDetails.value,
            ],
          ),
          builder: (context, _) {
            if (storeFrontDetails.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.amber),
                ),
              );
            }

            if (storeFrontDetails.error.value.isNotEmpty) {
              return Center(
                child: Text(storeFrontDetails.error.value),
              );
            }

            if (storeFrontDetails.value.value.title == null) {
              return const Center(
                child: Text('Nenhum dado encontrado!'),
              );
            }

            final frontDetails = storeFrontDetails.value.value;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      frontDetails.title ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InformationFrontWidget(
                      frontDetails: frontDetails,
                      deputyDetailsPage: deputyDetailsPage,
                    ),
                    const SizedBox(height: 10),
                    ListMembersWidget(
                      front: widget.front,
                      deputyDetailsPage: deputyDetailsPage,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
