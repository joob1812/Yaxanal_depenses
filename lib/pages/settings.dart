import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../utils/helpers.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _isPinEnabled = false;
  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Paramètres',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                // Thème de l'application
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Thème de l\'application'),
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                      _showThemeChangedSnackbar(context, value);
                    },
                    activeColor: const Color(0xFF4CAF50),
                  ),
                  onTap: () {
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                    _showThemeChangedSnackbar(context, !_isDarkMode);
                  },
                ),
                const Divider(),

                // Langue
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Langue'),
                  trailing: DropdownButton<String>(
                    value: _selectedLanguage,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'Français',
                        child: Text('Français'),
                      ),
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedLanguage = newValue;
                        });
                        _showLanguageChangedSnackbar(context, newValue);
                      }
                    },
                  ),
                ),
                const Divider(),

                // Code PIN
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Code PIN'),
                  trailing: Switch(
                    value: _isPinEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isPinEnabled = value;
                      });
                      if (value) {
                        _showSetPinDialog(context);
                      } else {
                        _showPinDisabledSnackbar(context);
                      }
                    },
                    activeColor: const Color(0xFF4CAF50),
                  ),
                ),
                const Divider(),

                // Sauvegarde des données
                ListTile(
                  leading: const Icon(Icons.backup),
                  title: const Text('Sauvegarde des données'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    _showBackupOptions(context);
                  },
                ),
                const Divider(),

                // Réinitialiser les données
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Réinitialiser les données',
                    style: TextStyle(color: Colors.red),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    _showResetDialog(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Yaxanal Dépenses v1.0.0\nApplication développée avec ❤ par Joob1812',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showThemeChangedSnackbar(BuildContext context, bool isDarkMode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isDarkMode ? 'Mode sombre activé' : 'Mode clair activé'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLanguageChangedSnackbar(BuildContext context, String language) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Langue changée: $language'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showPinDisabledSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code PIN désactivé'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showSetPinDialog(BuildContext context) {
    final pinController = TextEditingController();
    final confirmPinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Définir le code PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pinController,
              decoration: const InputDecoration(
                labelText: 'Nouveau code PIN (4 chiffres)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPinController,
              decoration: const InputDecoration(
                labelText: 'Confirmer le code PIN',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (pinController.text.length == 4 &&
                  pinController.text == confirmPinController.text) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Code PIN défini avec succès')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Les codes PIN ne correspondent pas ou sont invalides',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Valider'),
          ),
        ],
      ),
    );
  }

  void _showBackupOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sauvegarde des données'),
        content: const Text(
          'Exporter toutes les données au format CSV pour sauvegarde externe.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportDataToCsv(context);
            },
            child: const Text('Exporter CSV'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportDataToCsv(BuildContext context) async {
    try {
      final db = DatabaseHelper();
      final expenses = await db.getExpenses();

      if (expenses.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucune donnée à exporter')),
        );
        return;
      }

      // Simuler l'export CSV (dans un vrai projet, on écrirait dans un fichier)
      final csvData = StringBuffer();
      csvData.writeln('Titre,Montant,Date,Catégorie,Description');

      for (final expense in expenses) {
        csvData.writeln(
          '"${expense.title}",'
          '${expense.amount},'
          '${Helpers.formatDate(expense.date)},'
          '"${expense.category}",'
          '"${expense.description ?? ""}"',
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${expenses.length} dépenses exportées (simulation)'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );

      // En production, on utiliserait:
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/yaxanal_export_${DateTime.now().millisecondsSinceEpoch}.csv');
      // await file.writeAsString(csvData.toString());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'export: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialiser les données'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer toutes les données ? Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _resetAllData(context);
            },
            child: const Text(
              'Réinitialiser',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _resetAllData(BuildContext context) async {
    try {
      final db = DatabaseHelper();

      // Récupérer toutes les dépenses pour les supprimer une par une
      final expenses = await db.getExpenses();
      for (final expense in expenses) {
        if (expense.id != null) {
          await db.deleteExpense(expense.id!);
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${expenses.length} dépenses supprimées'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      // Notifier les autres pages du changement (via un Provider dans un vrai projet)
      // Pour l'instant, on montre juste un message
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la réinitialisation: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
