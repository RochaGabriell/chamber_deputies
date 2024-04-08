import 'package:flutter/material.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';
// Models for Deputies
import 'package:chamber_deputies/src/models/deputies.dart';
// Repositories and Stores for Deputies Details
import 'package:chamber_deputies/src/repositories/deputy_detail.dart';
import 'package:chamber_deputies/src/stores/deputy_details.dart';
// Widgets
import 'package:chamber_deputies/src/screens/deputy_details/widgets/information_widget.dart';
import 'package:chamber_deputies/src/screens/deputy_details/widgets/expenses_widget.dart';
import 'package:chamber_deputies/src/screens/deputy_details/widgets/occupations_widget.dart';
import 'package:chamber_deputies/src/screens/deputy_details/widgets/historic_widget.dart';

class DeputyDetails extends StatefulWidget {
  final DeputiesModels deputy;

  const DeputyDetails({
    super.key,
    required this.deputy,
  });

  @override
  State<DeputyDetails> createState() => _DeputyDetailsState();
}

class _DeputyDetailsState extends State<DeputyDetails> {
  static const String titleAppBar = 'Detalhes do Deputado';
  late DeputyDetailsStore storeDeputyDetails;

  @override
  void initState() {
    super.initState();

    storeDeputyDetails = DeputyDetailsStore(
      repository: DeputyDetailsRepository(
        client: HttpClient(),
        idDeputy: widget.deputy.id,
      ),
    );
    storeDeputyDetails.getDeputyDetails();
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
              storeDeputyDetails.isLoading,
              storeDeputyDetails.error,
              storeDeputyDetails.value,
            ],
          ),
          builder: (context, _) {
            if (storeDeputyDetails.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.amber),
                ),
              );
            }

            if (storeDeputyDetails.error.value.isNotEmpty) {
              return const Center(
                child: Text(
                  'Erro: Deputado não encontrado!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (storeDeputyDetails.value.value.name == null) {
              return const Center(
                child: Text('Nenhum dado encontrado!'),
              );
            }

            final deputyDetails = storeDeputyDetails.value.value;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      deputyDetails.civilName ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InformationDeputyWidget(
                      deputy: widget.deputy,
                      deputyDetails: deputyDetails,
                    ),
                    const SizedBox(height: 10),
                    ExpensesWidget(deputy: widget.deputy),
                    const SizedBox(height: 10),
                    OccupationsWidget(deputy: widget.deputy),
                    const SizedBox(height: 10),
                    HistoricWidget(deputy: widget.deputy),
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
