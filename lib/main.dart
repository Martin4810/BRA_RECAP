import 'package:bra_recap/settings-screen.dart';
import 'package:flutter/material.dart';
import 'avalanche-screen.dart';
import 'home-screen.dart';
import 'mountain-screen.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  isWinter = await readIntFromPref() == 1;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BRA Recap',
      home: Principal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Principal extends StatefulWidget {
  final Function(bool)? onThemeChanged;

  const Principal({super.key, this.onThemeChanged});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [HomeScreen(), AvalanchePage(), MountainPage(), SettingsScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: isWinter
            ? AppColors.primaryColorWinter
            : AppColors.primaryColorSummer,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Risque d\'avalanches',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.terrain), label: 'Montagne'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
