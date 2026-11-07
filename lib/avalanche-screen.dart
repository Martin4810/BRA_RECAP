import 'avalanche-api-request.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'home-screen.dart';

class AvalanchePage extends StatefulWidget {
  @override
  State<AvalanchePage> createState() => _AvalanchePageState();
}

class _AvalanchePageState extends State<AvalanchePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Risque d'avalanches"),
        backgroundColor: isWinter
            ? AppColors.primaryColorWinter
            : AppColors.primaryColorSummer,
        foregroundColor: isWinter
            ? AppColors.accentColorWinter
            : AppColors.accentColorSummer,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformationsPage()),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as List<Map<String, String>>;
          if (data.any((m) => m["risque"] == "?")) {
            Future.microtask(() {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Risque d'avalanche inconnu dans certains massifs",
                  ),
                  content: Text(
                    "Il se peut que certains massifs n'aient pas de BRA. Cela peut-être dû à la saison ou à d\'autres raisons. Veuillez vérifier les sources officielles pour plus d'informations.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            });
          }

          return ListView(
            children: data.map((m) {
              return ListTile(
                title: Text(
                  style: TextStyle(
                    color: m["risque"] == "1"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "2"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "3"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "4"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "5"
                        ? Color(0xFFE51E1B)
                        : Color.fromARGB(255, 0, 0, 0),
                  ),
                  m["nom"]!,
                ),
                subtitle: Text(
                  style: TextStyle(
                    color: m["risque"] == "1"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "2"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "3"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "4"
                        ? Color.fromARGB(255, 0, 0, 0)
                        : m["risque"] == "5"
                        ? Color(0xFFE51E1B)
                        : Color.fromARGB(255, 0, 0, 0),
                  ),
                  m["risque"] == "?"
                      ? "Risque d'avalanche inconnu"
                      : "Risque d'avalanche : ${m["risque"]}",
                ),
                trailing: SizedBox(
                  width: 100,
                  child: m["risque"] == "1"
                      ? Image.asset("assets/images/icon_1.jpg")
                      : m["risque"] == "2"
                      ? Image.asset("assets/images/icon_2.jpg")
                      : m["risque"] == "3"
                      ? Image.asset("assets/images/icon_3.jpg")
                      : m["risque"] == "4"
                      ? Image.asset("assets/images/icon_4.jpg")
                      : m["risque"] == "5"
                      ? Image.asset("assets/images/icon_5.jpg")
                      : Image.asset("assets/images/icon_0.jpg"),
                ),

                tileColor: m["risque"] == "1"
                    ? AppColors.risk1Color
                    : m["risque"] == "2"
                    ? AppColors.risk2Color
                    : m["risque"] == "3"
                    ? AppColors.risk3Color
                    : m["risque"] == "4"
                    ? AppColors.risk4Color
                    : m["risque"] == "5"
                    ? AppColors.risk5Color
                    : AppColors.unknownRiskColor,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsPage(nom: m["nom"]!, risque: m["risque"]!),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String nom;
  final String risque;

  const DetailsPage({super.key, required this.nom, required this.risque});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nom),
        backgroundColor: risque == "1"
            ? AppColors.risk1Color
            : risque == "2"
            ? AppColors.risk2Color
            : risque == "3"
            ? AppColors.risk3Color
            : risque == "4"
            ? AppColors.risk4Color
            : risque == "5"
            ? AppColors.risk5Color
            : AppColors.unknownRiskColor,
        foregroundColor: risque == "1"
            ? AppColors.riskTextLight
            : risque == "2"
            ? AppColors.riskTextLight
            : risque == "3"
            ? AppColors.riskTextLight
            : risque == "4"
            ? AppColors.riskTextLight
            : risque == "5"
            ? AppColors.riskTextDark
            : AppColors.riskTextLight,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style: TextStyle(
                fontSize: 24,
                color: risque == "1"
                    ? Color.fromARGB(255, 0, 0, 0)
                    : risque == "2"
                    ? Color.fromARGB(255, 0, 0, 0)
                    : risque == "3"
                    ? Color.fromARGB(255, 0, 0, 0)
                    : risque == "4"
                    ? Color.fromARGB(255, 0, 0, 0)
                    : risque == "5"
                    ? Color(0xFFE51E1B)
                    : Color.fromARGB(255, 0, 0, 0),
              ),
              "Risque d'avalanche : $risque",
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/*


















*/

class InformationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BRA Recap'),
        backgroundColor: isWinter
            ? AppColors.primaryColorWinter
            : AppColors.primaryColorSummer,
        foregroundColor: isWinter
            ? AppColors.accentColorWinter
            : AppColors.accentColorSummer,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with icon
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Icon(
                      Icons.terrain,
                      size: 80,
                      color: isWinter
                          ? AppColors.primaryColorWinter
                          : AppColors.primaryColorSummer,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Bulletin de Risque d\'Avalanche',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isWinter
                                ? AppColors.primaryColorWinter
                                : AppColors.primaryColorSummer,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Informations',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // About BRA
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
                            Icons.info,
                            color: isWinter
                                ? AppColors.primaryColorWinter
                                : AppColors.primaryColorSummer,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'À propos du BRA',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Cette application vous permet de consulter les Bulletins de Risque d\'Avalanche '
                        '(BRA) en temps réel pour l\'ensemble des massifs français: Alpes du Nord, Alpes du Sud, Pyrénées et Corse.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Risk levels guide
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
                            Icons.warning,
                            color: isWinter
                                ? AppColors.primaryColorWinter
                                : AppColors.primaryColorSummer,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Niveaux de risque',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset('assets/images/legend.jpg'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Quick tips
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
                        'Consultez toujours les sources officielles avant de partir en montagne.',
                        Icons.check_circle_outline,
                      ),
                      _buildTipRow(
                        'Ne partez jamais seul !',
                        Icons.warning_amber_outlined,
                      ),
                      _buildTipRow(
                        'Un risque faible ne signifie pas absence de risque. Restez vigilant.',
                        Icons.error_outline,
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

/*
Widget _buildRiskLevelRow(BuildContext context, String level, String label) {
  final color = Colors.blue;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              level,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}



*/

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
