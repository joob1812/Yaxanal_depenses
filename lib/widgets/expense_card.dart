import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../utils/helpers.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF4CAF50), // REMPLACÉ
          child: Text(
            expense.category[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${Helpers.formatDate(expense.date)} • ${expense.category}',
        ),
        trailing: Text(
          Helpers.formatCurrency(expense.amount),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4CAF50), // REMPLACÉ
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Supprimer la dépense'),
              content: const Text(
                'Êtes-vous sûr de vouloir supprimer cette dépense ?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Supprimer',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
