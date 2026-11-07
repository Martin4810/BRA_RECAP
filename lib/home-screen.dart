import 'package:bra_recap/constants.dart';
import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isWinter = true;

Future<void> addIntToPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('saison', isWinter ? 1 : 0);
}

Future<int> readIntFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int intvalue = prefs.getInt('saison') ?? 0;
  return intvalue;
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
        backgroundColor: isWinter
            ? AppColors.primaryColorWinter
            : AppColors.primaryColorSummer,
        foregroundColor: isWinter
            ? AppColors.accentColorWinter
            : AppColors.accentColorSummer,
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenue sur BRA Recap !",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isWinter
                        ? AppColors.primaryColorWinter
                        : AppColors.primaryColorSummer,
                  ),
                ),
                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RollingSwitch.icon(
                      initialState: isWinter,
                      onChanged: (bool state) {
                        setState(() => isWinter = state);
                        setState(() {});
                        addIntToPref();
                      },
                      rollingInfoRight: const RollingIconInfo(
                        icon: Icons.snowboarding,
                        text: Text('Hiver'),
                        backgroundColor: Colors.blue,
                      ),
                      rollingInfoLeft: const RollingIconInfo(
                        icon: Icons.sunny,
                        backgroundColor: Colors.yellow,
                        text: Text('Été'),
                      ),
                    ),
                    Text(isWinter ? " Mode hiver" : " Mode été"), //
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "BRA Recap est votre compagnon de confiance pour les activités de montagne. Que vous soyez un alpiniste chevronné ou un randonneur occasionnel, notre application vous offre des informations essentielles pour planifier vos aventures en toute sécurité.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  "Explorez les conditions météorologiques, les risques d'avalanche, et les itinéraires recommandés pour les massifs que vous souhaitez visiter. Restez informé et préparez-vous pour des expériences inoubliables en montagne avec BRA Recap !",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
