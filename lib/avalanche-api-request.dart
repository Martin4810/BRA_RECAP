import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> massifs = [
  {"id": 1, "nom": "Chablais", "region": "alpesNord"},
  {"id": 2, "nom": "Aravis", "region": "alpesNord"},
  {"id": 3, "nom": "Mont-Blanc", "region": "alpesNord"},
  {"id": 4, "nom": "Bauges", "region": "alpesNord"},
  {"id": 5, "nom": "Beaufortain", "region": "alpesNord"},
  {"id": 6, "nom": "Haute-Tarentaise", "region": "alpesNord"},
  {"id": 7, "nom": "Chartreuse", "region": "alpesNord"},
  {"id": 8, "nom": "Belledonne", "region": "alpesNord"},
  {"id": 9, "nom": "Maurienne", "region": "alpesNord"},
  {"id": 10, "nom": "Vanoise", "region": "alpesNord"},
  {"id": 11, "nom": "Haute-Maurienne", "region": "alpesNord"},
  {"id": 12, "nom": "Grandes Rousses", "region": "alpesNord"},
  {"id": 13, "nom": "Thabor", "region": "alpesNord"},
  {"id": 14, "nom": "Vercors", "region": "alpesNord"},
  {"id": 15, "nom": "Oisans", "region": "alpesNord"},
  {"id": 16, "nom": "Pelvoux", "region": "alpesSud"},
  {"id": 17, "nom": "Queyras", "region": "alpesSud"},
  {"id": 18, "nom": "Dévoluy", "region": "alpesSud"},
  {"id": 19, "nom": "Champsaur", "region": "alpesSud"},
  {"id": 20, "nom": "Embrunnais Parpaillon", "region": "alpesSud"},
  {"id": 21, "nom": "Ubaye", "region": "alpesSud"},
  {"id": 22, "nom": "Haut-Var Haut-Verdon", "region": "alpesSud"},
  {"id": 23, "nom": "Mercantour", "region": "alpesSud"},
  {"id": 40, "nom": "Cinto Rotondo", "region": "corse"},
  {"id": 41, "nom": "Renoso Incudine", "region": "corse"},
  {"id": 64, "nom": "Pays-Basque", "region": "pyrenees"},
  {"id": 65, "nom": "Aspe Ossau", "region": "pyrenees"},
  {"id": 66, "nom": "Haute-Bigorre", "region": "pyrenees"},
  {"id": 67, "nom": "Aure Louron", "region": "pyrenees"},
  {"id": 68, "nom": "Luchonnais", "region": "pyrenees"},
  {"id": 69, "nom": "Couserans", "region": "pyrenees"},
  {"id": 70, "nom": "Haute-Ariege", "region": "pyrenees"},
  {"id": 72, "nom": "Orlu St-Barthelemy", "region": "pyrenees"},
  {"id": 73, "nom": "Capcir Puymorens", "region": "pyrenees"},
  {"id": 74, "nom": "Cerdagne Canigou", "region": "pyrenees"},
  {"id": 99, "nom": "Test massif non présent dans l'api", "region": "test"},
];

List<Map<String, dynamic>> getFilteredMassifs(
  bool alpesNord,
  bool alpesSud,
  bool pyrenees,
  bool corse,
  bool test,
) {
  List<Map<String, dynamic>> filtered = [];

  if (alpesNord) {
    filtered.addAll(
      massifs.where((m) => m['region'] == 'alpesNord'),
    ); // Ajoute les massifs des Alpes du Nord si sélectionné
  }
  if (alpesSud) {
    filtered.addAll(massifs.where((m) => m['region'] == 'alpesSud'));
  }
  if (pyrenees) {
    filtered.addAll(massifs.where((m) => m['region'] == 'pyrenees'));
  }
  if (corse) {
    filtered.addAll(massifs.where((m) => m['region'] == 'corse'));
  }
  if (test) {
    filtered.addAll(massifs.where((m) => m['region'] == 'test'));
  }

  return filtered;
}

final String authHeader =
    "Basic NjlZdzQxUWpCaU9zNnhJX1lyM2ZHMWNpZmNjYTozZ1RRb0JKcUVpbHFXQlhKRWpGNWVFU1BFbjRh";

// Cache du token
String? _cachedToken;
DateTime? _tokenExpiry;

Future<String> getToken() async {
  //
  if (_cachedToken != null &&
      _tokenExpiry != null &&
      _tokenExpiry!.isAfter(DateTime.now())) {
    return _cachedToken!;
  }

  final response = await http.post(
    Uri.parse("https://portail-api.meteofrance.fr/token"),
    headers: {"Authorization": authHeader},
    body: {"grant_type": "client_credentials"},
  );

  final data = jsonDecode(response.body);

  _cachedToken = data["access_token"];
  _tokenExpiry = DateTime.now().add(Duration(seconds: data["expires_in"]));

  return _cachedToken!;
}

Future<String> getRisque(int massifId, String token) async {
  final url =
      "https://public-api.meteofrance.fr/public/DPBRA/v1/massif/BRA?id-massif=$massifId&format=xml";

  final response = await http.get(
    Uri.parse(url),
    headers: {"Authorization": "Bearer $token"},
  );

  if (response.statusCode != 200) return "?";

  final doc = XmlDocument.parse(response.body);

  final risque = doc.findAllElements("RISQUE").first.getAttribute("RISQUEMAXI");

  return risque ?? "?";
}

Future<List<Map<String, String>>> loadData() async {
  final prefs = await SharedPreferences.getInstance();

  final alpesNord = prefs.getBool('alpesNord') ?? true;
  final alpesSud = prefs.getBool('alpesSud') ?? true;
  final pyrenees = prefs.getBool('pyrenees') ?? true;
  final corse = prefs.getBool('corse') ?? true;
  final test = prefs.getBool('test') ?? true;

  final token = await getToken();

  //  On récupère les massifs filtrés
  final filtered = getFilteredMassifs(
    alpesNord,
    alpesSud,
    pyrenees,
    corse,
    test,
  );

  //  On lance les requêtes API uniquement pour ceux-là
  final futures = filtered.map((m) async {
    final risque = await getRisque(m["id"] as int, token);
    return {"nom": m["nom"] as String, "risque": risque};
  });

  List<Map<String, String>> data = await Future.wait(futures);

  //  Ajout des massifs de test
  if (test) {
    final massifsTest = List.generate(5, (i) {
      return {"nom": "Massif Test ${i + 1}", "risque": "${i + 1}"};
    });

    data.addAll(massifsTest);
  }

  return data;
}
