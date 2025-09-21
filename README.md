# Guide pour mettre l'application Yaxanal sur GitHub

## 1. Préparation du projet

### Fichier .gitignore
Créez un fichier `.gitignore` à la racine du projet avec ce contenu :

```
# Flutter
/flutter/
*.swp
*.swo
*~
.DS_Store
.dart_tool/
.packages
.pub-cache/
.pub/
build/
android/app/src/main/java/io/flutter/plugins/
android/app/src/main/kotlin/io/flutter/plugins/
ios/Flutter/.last_build_id
ios/Runner/GeneratedPluginRegistrant.*
.vagrant/

# Android
android/**/GeneratedPluginRegistrant.java
android/**/android_gen/
android/.gradle/
android/local.properties
android/**/GeneratedPluginRegistrant.java

# iOS
ios/**/*.mode1v3
ios/**/*.mode2v3
ios/**/*.moved-aside
ios/**/*.pbxuser
ios/**/*.perspectivev3
ios/**/*sync/
ios/.symlinks/
ios/Flutter/App.framework/
ios/Flutter/Flutter.framework/
ios/Flutter/Generated.xcconfig
ios/Flutter/app.flx
ios/Flutter/app.zip
ios/Flutter/flutter_assets/
ios/ServiceDefinitions.json
ios/Runner/GeneratedPluginRegistrant.*

# IntelliJ
.idea/
*.iml
*.iws
*.ipr

# Visual Studio Code
.vscode/

# macOS
.DS_Store
.AppleDouble
.LSOverride

# Windows
Thumbs.db
ehthumbs.db

# Files
*.log
*.tmp
*.orig
*.class

# Packages
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Database
*.db
*.sqlite
```

## 2. Initialisation de Git

Ouvrez le terminal dans le dossier du projet et exécutez :

```bash
# Initialiser le dépôt Git
git init

# Ajouter tous les fichiers
git add .

# Faire le premier commit
git commit -m "Initial commit: Application Yaxanal - Gestion des dépenses"
```

## 3. Création du dépôt GitHub

1. Allez sur [GitHub.com](https://github.com)
2. Cliquez sur "New repository"
3. Nommez le dépôt : `yaxanal-expenses`
4. Description : `Application de gestion des dépenses développée avec Flutter - Projet académique`
5. Choisissez "Public" (pour un projet académique)
6. Ne pas initialiser avec README (puisque vous avez déjà un projet)

## 4. Lier le dépôt local à GitHub

```bash
# Ajouter le remote (remplacez VOTRE_NOM_UTILISATEUR par votre username GitHub)
git remote add origin https://github.com/VOTRE_NOM_UTILISATEUR/yaxanal-expenses.git

# Pousser le code
git branch -M main
git push -u origin main
```

## 5. Fichier README.md

Créez un fichier `README.md` à la racine du projet :

```markdown
# Yaxanal - Application de Gestion des Dépenses

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-2.19+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

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
git clone https://github.com/VOTRE_NOM_UTILISATEUR/yaxanal-expenses.git
cd yaxanal-expenses
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

## 📊 Captures d'Écran

| Page d'Accueil | Ajout de Dépense | Statistiques |
|----------------|------------------|--------------|
| ![Home](https://via.placeholder.com/150) | ![Add](https://via.placeholder.com/150) | ![Stats](https://via.placeholder.com/150) |

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

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 👨‍💻 Auteur

[Développé par] - [Projet Académique Yaxanal]

---

**Note** : Cette application est une démonstration et ne doit pas être utilisée pour la gestion financière réelle sans tests supplémentaires.
```

## 6. Fichier LICENSE (Optionnel)

Créez un fichier `LICENSE` à la racine :

```text
MIT License

Copyright (c) 2024 [Votre Nom]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 7. Commandes finales

```bash
# Ajouter le README et LICENSE
git add README.md LICENSE

# Commit des nouveaux fichiers
git commit -m "Add README and LICENSE"

# Pousser vers GitHub
git push origin main
```

## 8. Badges optionnels (pour le README)

Vous pouvez ajouter ces badges en haut de votre README après la création du dépôt :

```markdown
![GitHub last commit](https://img.shields.io/github/last-commit/VOTRE_NOM_UTILISATEUR/yaxanal-expenses)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/VOTRE_NOM_UTILISATEUR/yaxanal-expenses)
![GitHub issues](https://img.shields.io/github/issues/VOTRE_NOM_UTILISATEUR/yaxanal-expenses)
```
