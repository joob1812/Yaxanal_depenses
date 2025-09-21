import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../models/expense.dart';
import '../utils/helpers.dart';
import '../widgets/expense_card.dart';
import 'add_expense.dart';
import 'expenses_list.dart';
import 'statistics.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  double totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTotalExpenses();
  }

  Future<void> _loadTotalExpenses() async {
    final db = DatabaseHelper();
    final total = await db.getTotalExpenses();
    setState(() {
      totalExpenses = total;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yaxanal Dépenses'),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadTotalExpenses,
            ),
        ],
      ),
      body: _getPage(_selectedIndex),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddExpensePage(),
                  ),
                );
                _loadTotalExpenses();
              },
              backgroundColor: const Color(0xFF4CAF50),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Dépenses'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePage();
      case 1:
        return const ExpensesListPage();
      case 2:
        return const StatisticsPage();
      case 3:
        return const SettingsPage();
      default:
        return const Center(child: Text('Page non trouvée'));
    }
  }

  Widget _buildHomePage() {
    return FutureBuilder<List<Expense>>(
      future: DatabaseHelper().getExpenses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        final expenses = snapshot.data ?? [];
        final recentExpenses = expenses.take(5).toList();

        return SingleChildScrollView(
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
                        Helpers.formatCurrency(totalExpenses),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Dépenses récentes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (recentExpenses.isEmpty)
                const Center(child: Text('Aucune dépense enregistrée'))
              else
                Column(
                  children: recentExpenses
                      .map(
                        (expense) => ExpenseCard(
                          expense: expense,
                          onTap: () {
                            // Option: Implement edit functionality later
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) => EditExpensePage(expense: expense),
                            // )).then((_) => _loadTotalExpenses());
                          },
                          onDelete: () async {
                            await DatabaseHelper().deleteExpense(expense.id!);
                            _loadTotalExpenses();
                            setState(() {});
                          },
                        ),
                      )
                      .toList(),
                ),
              if (expenses.length > 5)
                Center(
                  child: TextButton(
                    onPressed: () => _onItemTapped(1),
                    child: const Text('Voir toutes les dépenses'),
                  ),
                ),
              const SizedBox(height: 16),
              // Section for quick stats
              if (recentExpenses.isNotEmpty) _buildQuickStats(expenses),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickStats(List<Expense> expenses) {
    // Calculate monthly total
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final monthlyExpenses = expenses
        .where((expense) => expense.date.isAfter(firstDayOfMonth))
        .toList();

    final monthlyTotal = monthlyExpenses.fold(
      0.0,
      (sum, expense) => sum + expense.amount,
    );

    // Count expenses by category
    final categoryCount = <String, int>{};
    for (var expense in expenses) {
      categoryCount[expense.category] =
          (categoryCount[expense.category] ?? 0) + 1;
    }

    // Get most frequent category
    String mostFrequentCategory = 'Aucune';
    if (categoryCount.isNotEmpty) {
      mostFrequentCategory = categoryCount.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Statistiques rapides',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          children: [
            _buildStatCard(
              title: 'Ce mois-ci',
              value: Helpers.formatCurrency(monthlyTotal),
              icon: Icons.calendar_today,
            ),
            _buildStatCard(
              title: 'Nombre total',
              value: '${expenses.length}',
              icon: Icons.list,
            ),
            _buildStatCard(
              title: 'Catégorie favorite',
              value: mostFrequentCategory,
              icon: Icons.star,
            ),
            _buildStatCard(
              title: 'Moyenne/mois',
              value: Helpers.formatCurrency(monthlyTotal),
              icon: Icons.trending_up,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: const Color(0xFF4CAF50)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
