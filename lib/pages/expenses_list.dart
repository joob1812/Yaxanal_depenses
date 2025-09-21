import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../models/expense.dart';
import '../widgets/expense_card.dart';

class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key});

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage> {
  List<Expense> _expenses = [];
  String _filterCategory = 'Toutes';
  List<String> _categories = ['Toutes'];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
    _loadCategories();
  }

  Future<void> _loadExpenses() async {
    final db = DatabaseHelper();
    final expenses = await db.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  Future<void> _loadCategories() async {
    final db = DatabaseHelper();
    final categories = await db.getCategories();
    setState(() {
      _categories = ['Toutes', ...categories.map((c) => c.name)];
    });
  }

  List<Expense> _getFilteredExpenses() {
    if (_filterCategory == 'Toutes') {
      return _expenses;
    }
    return _expenses
        .where((expense) => expense.category == _filterCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = _getFilteredExpenses();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField<String>(
            value: _filterCategory,
            decoration: const InputDecoration(
              labelText: 'Filtrer par catégorie',
              border: OutlineInputBorder(),
            ),
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _filterCategory = newValue!;
              });
            },
          ),
        ),
        Expanded(
          child: filteredExpenses.isEmpty
              ? const Center(child: Text('Aucune dépense à afficher'))
              : ListView.builder(
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = filteredExpenses[index];
                    return ExpenseCard(
                      expense: expense,
                      onTap: () {
                        // TODO: Implement edit expense
                      },
                      onDelete: () async {
                        await DatabaseHelper().deleteExpense(expense.id!);
                        _loadExpenses();
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
