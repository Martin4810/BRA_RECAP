import 'package:flutter/material.dart';
import 'constants.dart';
import 'home-screen.dart';

class MountainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Montagne"),
        backgroundColor: isWinter
            ? AppColors.primaryColorWinter
            : AppColors.primaryColorSummer,
        foregroundColor: isWinter
            ? AppColors.accentColorWinter
            : AppColors.accentColorSummer,
      ),
      body: Center(child: Text("Contenu des montagnes ici")),
    );
  }
}
