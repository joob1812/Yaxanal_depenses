```markdown
# Yaxanal - Application de Gestion des Dépenses

Une application mobile de gestion des dépenses personnelles développée avec Flutter dans le cadre d'un projet académique.

## 📱 Fonctionnalités

- ✅ Enregistrement des dépenses avec catégorisation
- ✅ Visualisation des statistiques et graphiques
- ✅ Gestion des budgets par catégorie
- ✅ Historique des transactions avec filtres
- ✅ Interface intuitive et responsive
- ✅ Mode sombre/clair
- ✅ Sauvegarde locale des données

## 🛠️ Technologies Utilisées

- **Framework** : Flutter 3.0+
- **Langage** : Dart
- **Base de données** : SQLite avec sqflite
- **Graphiques** : Custom Paint pour les visualisations
- **Architecture** : MVC simple

## 📦 Installation

### Prérequis

- Flutter SDK 3.0 ou supérieur
- Dart 2.19 ou supérieur
- Un émulateur ou appareil Android/iOS

### Étapes d'installation

1. Cloner le dépôt :
```bash
git clone https://github.com/joob1812/yaxanal-depenses.git
cd yaxanal-depenses
```

2. Installer les dépendances :
```bash
flutter pub get
```

3. Lancer l'application :
```bash
flutter run
```

## 🏗️ Structure du Projet

```
lib/
├── data/
│   └── database_helper.dart    # Gestion de la base de données
├── models/
│   ├── expense.dart           # Modèle de dépense
│   └── category.dart          # Modèle de catégorie
├── pages/
│   ├── home_page.dart         # Page d'accueil
│   ├── add_expense.dart       # Ajout de dépense
│   ├── expenses_list.dart     # Liste des dépenses
│   ├── statistics.dart        # Statistiques
│   └── settings.dart          # Paramètres
├── widgets/
│   ├── expense_card.dart      # Carte de dépense
│   ├── category_chip.dart     # Chip de catégorie
│   └── pie_chart.dart         # Graphique circulaire
├── utils/
│   ├── constants.dart         # Constantes de l'app
│   └── helpers.dart           # Fonctions utilitaires
└── main.dart                  # Point d'entrée
```
## 🚀 Fonctionnalités Implémentées

- [x] CRUD complet des dépenses
- [x] Base de données SQLite locale
- [x] Interface utilisateur responsive
- [x] Graphiques de statistiques
- [x] Système de catégories
- [x] Gestion des paramètres
- [x] Export des données (simulé)

## 📝 Projet Académique

Ce projet a été développé dans le cadre d'un projet académique pour demonstrer les compétences en :
- Développement mobile avec Flutter
- Gestion de base de données SQLite
- Conception d'interface utilisateur
- Architecture d'application

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changes (`git commit -m 'Add some AmazingFeature'`)
4. Push sur la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 👨‍💻 Auteur

[Développé par] - [joob1812]

---

**Note** : Cette application est une démonstration et ne doit pas être utilisée pour la gestion financière réelle sans tests supplémentaires.