import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:chamber_deputies/src/repositories/deputy_detail.dart';
import 'package:chamber_deputies/src/stores/deputy_details.dart';
import 'package:chamber_deputies/src/repositories/expense.dart';
import 'package:chamber_deputies/src/stores/expense.dart';
import 'package:chamber_deputies/src/models/expense.dart';

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
  late ExpenseStore storeExpense;

  final List<Map<int, String>> months = [
    {0: 'Mês'},
    {1: 'Janeiro'},
    {2: 'Fevereiro'},
    {3: 'Março'},
    {4: 'Abril'},
    {5: 'Maio'},
    {6: 'Junho'},
    {7: 'Julho'},
    {8: 'Agosto'},
    {9: 'Setembro'},
    {10: 'Outubro'},
    {11: 'Novembro'},
    {12: 'Dezembro'},
  ];
  final List<int> years = [
    2024,
    2023,
    2022,
    2021,
    2020,
    2019,
  ];
  int _getMonth = 0;
  int _getYear = 2024;

  void _changeMonth(int month) {
    setState(() {
      _getMonth = month;
    });
  }

  void _changeYear(int year) {
    setState(() {
      _getYear = year;
    });
  }

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

    storeExpense = ExpenseStore(
      repository: ExpenseRepository(
        client: HttpClient(),
        idDeputy: widget.deputy.id,
      ),
    );
    storeExpense.getExpenses();
  }

  List<ExpenseModel> getExpensesByMonthYear(int month, int year) {
    storeExpense.getExpensesByMonthYear(month, year);
    print('$month' + '$year');
    return storeExpense.value.value;
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
              // Store de detalhes do deputado
              storeDeputyDetails.isLoading,
              storeDeputyDetails.error,
              storeDeputyDetails.value,
              // Store de despesas
              storeExpense.isLoading,
              storeExpense.error,
              storeExpense.value,
            ],
          ),
          builder: (context, _) {
            if (storeDeputyDetails.isLoading.value ||
                storeExpense.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.amber),
                ),
              );
            }

            if (storeDeputyDetails.error.value.isNotEmpty) {
              return Center(
                child: Text(storeDeputyDetails.error.value),
              );
            }

            if (storeDeputyDetails.value.value.name == null) {
              return const Center(
                child: Text('Nenhum dado encontrado!'),
              );
            }

            final deputyDetails = storeDeputyDetails.value.value;
            final expenses = storeExpense.value.value;

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
                    const SizedBox(height: 10),
                    Container(
                      // Primeiro Container - Informações do Deputado
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
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
                      child: SizedBox(
                        height: 230,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              child: Column(
                                children: [
                                  const Text(
                                    'Informações do Deputado',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                widget.deputy.urlPhoto,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            if (widget.deputy.name.length > 15)
                                              Text(
                                                '${widget.deputy.name.substring(0, 14)}...',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            if (widget.deputy.name.length <= 15)
                                              Text(
                                                widget.deputy.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  color: Colors.white,
                                                  Icons.group,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  widget.deputy.party,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  color: Colors.white,
                                                  Icons.location_on,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  widget.deputy.uf,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'Situação:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  deputyDetails.situation ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Condição Eleitoral:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Flexible(
                                                  child: Text(
                                                    deputyDetails.condition ??
                                                        '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Escolaridade:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Flexible(
                                                  child: Text(
                                                    deputyDetails.education ??
                                                        '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Gênero:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  deputyDetails.sex ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'UF Nascimento: ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  deputyDetails.birthUf ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Data de Nasc.:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Flexible(
                                                  child: Text(
                                                    deputyDetails.birthDate ??
                                                        '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (deputyDetails.deathDate != '')
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Data de Falec.:',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    deputyDetails.deathDate ??
                                                        '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'CPF:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  deputyDetails.cpf ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 20,
                                child: Column(
                                  children: [
                                    const Text(
                                      'Gabinete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    for (var cabinet
                                        in deputyDetails.cabinet!.entries)
                                      Row(
                                        children: [
                                          Text(
                                            '${cabinet.key[0].toUpperCase() + cabinet.key.substring(1)}: ',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            cabinet.value ?? '-',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // Segundo Container - Despesas do Deputado
                      padding: const EdgeInsets.all(10),
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
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Despesas',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Total:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        expenses.isEmpty
                                            ? 'R\$ 0.00'
                                            : 'R\$ ${expenses.fold<double>(0, (total, expense) => total + expense.documentValue).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              // Dropdown para selecionar o mês
                              DropdownButton<String>(
                                value: months[_getMonth].values.first,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                onChanged: (String? value) => setState(() {
                                  final month = months.indexWhere((element) {
                                    return element.values.contains(value);
                                  });
                                  _changeMonth(month);
                                  getExpensesByMonthYear(_getMonth, _getYear);
                                }),
                                items: [
                                  for (final month in months)
                                    DropdownMenuItem(
                                      value: month.values.first,
                                      child: Text(
                                        month.values.first,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 5),
                              // Dropdown para selecionar o ano
                              DropdownButton<int>(
                                value: years[years.indexOf(_getYear)],
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                onChanged: (int? value) => setState(() {
                                  _changeYear(value!);
                                  getExpensesByMonthYear(_getMonth, _getYear);
                                }),
                                items: [
                                  for (final year in years)
                                    DropdownMenuItem(
                                      value: year,
                                      child: Text(
                                        year.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 300,
                            child: expenses.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Nenhuma despesa encontrada para o mês e ano selecionados!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: expenses.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final expense = expenses[index];
                                      return Container(
                                        width: 350,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      expense.documentType,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Nº ${expense.documentNumber.replaceAll(
                                                        RegExp(r'\D'),
                                                        '',
                                                      )}',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${expense.month}/${expense.year}',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Valor:',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          'R\$ ${expense.documentValue.toStringAsFixed(2)}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color:
                                                  Color.fromRGBO(22, 49, 21, 1),
                                              thickness: 1,
                                            ),
                                            const Text(
                                              'Tipo:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              expense.type,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'Fornecedor:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              expense.providerName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'CNPJ/CPF do Fornecedor:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              expense.providerCnpj,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // Terceiro Container - Ocupações do Deputado
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
                            'Ocupações do Deputado',
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
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // Quarto Container - Histórico do Deputado
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
