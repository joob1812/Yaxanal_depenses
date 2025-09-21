import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../widgets/pie_chart.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Map<String, double> _expensesByCategory = {};
  double _totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final db = DatabaseHelper();
    final expensesByCategory = await db.getExpensesByCategory();
    final totalExpenses = await db.getTotalExpenses();

    setState(() {
      _expensesByCategory = expensesByCategory;
      _totalExpenses = totalExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Dépenses totales',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Helpers.formatCurrency(_totalExpenses),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Répartition par catégorie',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _expensesByCategory.isEmpty
                ? const Center(child: Text('Aucune donnée à afficher'))
                : ExpensePieChart(data: _expensesByCategory),
          ),
        ],
      ),
    );
  }
}
