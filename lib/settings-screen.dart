import 'package:bra_recap/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home-screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
        backgroundColor: isWinter
            ? AppColors.primaryColorWinter
            : AppColors.primaryColorSummer,
        foregroundColor: isWinter
            ? AppColors.accentColorWinter
            : AppColors.accentColorSummer,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.brightness_6,
                  color: isWinter
                      ? AppColors.primaryColorWinter
                      : AppColors.primaryColorSummer,
                ),
                title: Text('Thème sombre'),
                subtitle: Text('Activer ou désactiver le thème sombre'),
                trailing: Switch(
                  value: false, // Remplacez par votre logique de thème
                  onChanged: null,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: isWinter
                      ? AppColors.primaryColorWinter
                      : AppColors.primaryColorSummer,
                ),
                title: Text('Langue'),
                subtitle: Text('Choisir la langue de l\'application'),
                onTap: () {
                  // Implémentez la logique pour changer la langue
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: isWinter
                      ? AppColors.primaryColorWinter
                      : AppColors.primaryColorSummer,
                ),
                title: Text('Notifications'),
                subtitle: Text('Gérer les notifications de l\'application'),
                onTap: () {
                  // Implémentez la logique pour gérer les notifications
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.terrain,
                  color: isWinter
                      ? AppColors.primaryColorWinter
                      : AppColors.primaryColorSummer,
                ),
                title: Text('Sélection des massifs'),
                subtitle: Text('Sélectionner les massifs à afficher'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MassifSelectionPage(),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: isWinter
                      ? AppColors.primaryColorWinter
                      : AppColors.primaryColorSummer,
                ),
                title: Text('À propos'),
                subtitle: Text('Informations sur l\'application'),
                onTap: () {
                  // Implémentez la logique pour afficher les informations sur l'application
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MassifSelectionPage extends StatefulWidget {
  @override
  State<MassifSelectionPage> createState() => _MassifSelectionPageState();
}

class _MassifSelectionPageState extends State<MassifSelectionPage> {
  bool alpesNord = true;
  bool alpesSud = true;
  bool pyrenees = true;
  bool corse = true;
  bool test = true;

  bool value = true;

  @override
  void initState() {
    // méthode appelée lors de l'initialisation du widget, elle charge les paramètres enregistrés
    super.initState();
    _loadSettings(); // charge les paramètres enregistrés lors de l'initialisation du widget
  }

  Future<void> _loadSettings() async {
    // méthode pour charger les paramètres enregistrés depuis les SharedPreferences, elle met à jour l'état du widget avec les valeurs récupérées
    final prefs = await SharedPreferences.getInstance(); //
    setState(() {
      alpesNord = prefs.getBool('alpesNord') ?? true;
      alpesSud = prefs.getBool('alpesSud') ?? true;
      pyrenees = prefs.getBool('pyrenees') ?? true;
      corse = prefs.getBool('corse') ?? true;
      test = prefs.getBool('test') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    // méthode pour enregistrer les paramètres dans les SharedPreferences, elle est appelée à chaque fois qu'un paramètre est modifié
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alpesNord', alpesNord);
    await prefs.setBool('alpesSud', alpesSud);
    await prefs.setBool('pyrenees', pyrenees);
    await prefs.setBool('corse', corse);
    await prefs.setBool('test', test);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
        backgroundColor: isWinter
            ? AppColors.primaryColorWinter
            : AppColors.primaryColorSummer,
        foregroundColor: isWinter
            ? AppColors.accentColorWinter
            : AppColors.accentColorSummer,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Massifs affichés :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SwitchListTile(
                      title: Text('Alpes du Nord'),
                      value: alpesNord,
                      activeTrackColor: isWinter
                          ? AppColors.primaryColorWinter
                          : AppColors.primaryColorSummer,
                      onChanged: (value) {
                        setState(() => alpesNord = value);
                        _saveSettings();
                      },
                    ),
                    SwitchListTile(
                      title: Text('Alpes du Sud'),
                      value: alpesSud,
                      activeTrackColor: isWinter
                          ? AppColors.primaryColorWinter
                          : AppColors.primaryColorSummer,
                      onChanged: (value) {
                        setState(() => alpesSud = value);
                        _saveSettings();
                      },
                    ),
                    SwitchListTile(
                      title: Text('Pyrénées'),
                      value: pyrenees,
                      activeTrackColor: isWinter
                          ? AppColors.primaryColorWinter
                          : AppColors.primaryColorSummer,
                      onChanged: (value) {
                        setState(() => pyrenees = value);
                        _saveSettings();
                      },
                    ),
                    SwitchListTile(
                      title: Text('Corse'),
                      value: corse,
                      activeTrackColor: isWinter
                          ? AppColors.primaryColorWinter
                          : AppColors.primaryColorSummer,
                      onChanged: (value) {
                        setState(() => corse = value);
                        _saveSettings();
                      },
                    ),
                    SwitchListTile(
                      title: Text('Test'),
                      value: test,
                      activeTrackColor: isWinter
                          ? AppColors.primaryColorWinter
                          : AppColors.primaryColorSummer,
                      onChanged: (value) {
                        setState(() => test = value);
                        _saveSettings();
                      },
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'L\'onglet "test" est destiné à des fins de développement et de test. Il contient les 5 niveaux et un massif non existant pour tester les fonctionnalités de l\'application. L\'activer ne changera rien hormis 6 massifs "tests" qui s\'afficheront dans la liste des massifs.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),

                    // Ajoutez d'autres paramètres ici
                  ],
                ),
              ),
              Card(
                elevation: 2,
                color: AppColors.surfaceColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: isWinter
                                ? AppColors.primaryColorWinter
                                : AppColors.primaryColorSummer,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Conseils',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTipRow(
                        "Ne mettre que les massifs que l'on regarde accélère le temps de chargement.",
                        Icons.speed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTipRow(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isWinter
              ? AppColors.primaryColorWinter
              : AppColors.primaryColorSummer,
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
