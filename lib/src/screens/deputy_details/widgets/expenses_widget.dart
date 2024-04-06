import 'package:flutter/material.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';
// Models of Deputies
import 'package:chamber_deputies/src/models/expense.dart';
// Models, Repositories and Stores of Expenses
import 'package:chamber_deputies/src/models/deputies.dart';
import 'package:chamber_deputies/src/repositories/expense.dart';
import 'package:chamber_deputies/src/stores/expense.dart';

class ExpensesWidget extends StatefulWidget {
  final DeputiesModels deputy;

  const ExpensesWidget({
    super.key,
    required this.deputy,
  });

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
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

  @override
  void initState() {
    super.initState();

    storeExpense = ExpenseStore(
      repository: ExpenseRepository(
        client: HttpClient(),
        idDeputy: widget.deputy.id,
      ),
    );
    storeExpense.getExpenses().then((expenses) {
      setState(() {});
    });
  }

  void _changeMonth(int month) {
    setState(() {
      _getMonth = month;
    });
    _updateExpenses();
  }

  void _changeYear(int year) {
    setState(() {
      _getYear = year;
    });
    _updateExpenses();
  }

  void _updateExpenses() {
    getExpensesByMonthYear(_getMonth, _getYear).then((expenses) {
      setState(
        () {},
      );
    });
  }

  Future<List<ExpenseModel>> getExpensesByMonthYear(int month, int year) async {
    await storeExpense.getExpensesByMonthYear(month, year);
    return storeExpense.value.value;
  }

  @override
  Widget build(BuildContext context) {
    final expenses = storeExpense.value.value;

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
            decoration: const BoxDecoration(
              color: Color.fromRGBO(207, 36, 27, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
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
                            fontSize: 18,
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
                            fontSize: 18,
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
                  }),
                  dropdownColor: const Color.fromRGBO(207, 36, 27, 1),
                  items: [
                    for (final month in months)
                      DropdownMenuItem(
                        value: month.values.first,
                        child: Text(
                          month.values.first,
                          style: const TextStyle(
                            color: Colors.white,
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
                  }),
                  dropdownColor: const Color.fromRGBO(207, 36, 27, 1),
                  items: [
                    for (final year in years)
                      DropdownMenuItem(
                        value: year,
                        child: Text(
                          year.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: SizedBox(
              height: 320,
              child: AnimatedBuilder(
                animation: Listenable.merge(
                  [
                    storeExpense.error,
                    storeExpense.isLoading,
                    storeExpense.value,
                  ],
                ),
                builder: (context, _) {
                  if (storeExpense.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.amber),
                      ),
                    );
                  }

                  if (storeExpense.error.value.isNotEmpty) {
                    return Center(
                      child: Text(storeExpense.error.value),
                    );
                  }

                  if (storeExpense.value.value.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhuma despesa encontrada para o mês e ano selecionados!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: expenses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return Container(
                        width: 350,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      expense.documentType,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Nº ${expense.documentNumber.replaceAll(
                                        RegExp(r'\D'),
                                        '',
                                      )}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${expense.month}/${expense.year}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Valor:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'R\$ ${expense.documentValue.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              color: Color.fromRGBO(22, 49, 21, 1),
                              thickness: 1,
                            ),
                            const Text(
                              'Tipo:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              expense.type,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Fornecedor:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              expense.providerName,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'CNPJ/CPF do Fornecedor:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              expense.providerCnpj,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
