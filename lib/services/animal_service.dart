import 'package:app/models/models.dart';
import 'package:app/services/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnimalService extends ChangeNotifier {
  List<AnimalModel> animales = [];
  bool isLoading = true;

  AnimalService() {
    load();
  }

  Future<List<AnimalModel>> load({bool isUsedLoading = true}) async {
    if (isUsedLoading) {
      isLoading = true;
      notifyListeners();
    }

    final url = Uri.parse(
        'https://crudsergio-ace1-default-rtdb.firebaseio.com/Animales.json');

    final response = await http.get(url);
    animales.clear();

    if (response.body != "null") {
      final Map<String, dynamic> animalesMap = json.decode(response.body);
      animalesMap.forEach((key, value) {
        final animalTemp = AnimalModel.fromJson(value);
        animalTemp.id = key;
        animales.add(animalTemp);
      });
    }

    if (isUsedLoading) isLoading = false;
    notifyListeners();

    return animales;
  }

  Future<void> post(AnimalModel animal) async {
    final url = Uri.parse(
        'https://crudsergio-ace1-default-rtdb.firebaseio.com/Animales.json');

    String data = jsonEncode(animal);
    final response = await http.post(url, body: data);
    load();
  }

  Future<void> put(AnimalModel animal) async {
    final url = Uri.parse(
        'https://crudsergio-ace1-default-rtdb.firebaseio.com/Animales/${animal.id}.json');

    String data = jsonEncode(animal);
    final response = await http.put(url, body: data);
    load();
  }

  Future<void> delete(AnimalModel animal) async {
    final url = Uri.parse(
        'https://crudsergio-ace1-default-rtdb.firebaseio.com/Animales/${animal.id}.json');

    final response = await http.delete(url);
    load();
  }

  Future<void> saveLocally(List<AnimalModel> animales) async {
    final prefs = await SharedPreferences.getInstance();
    final animalesJson = animales.map((animal) => animal.toJson()).toList();
    await prefs.setStringList(
        'animales', animalesJson.map((e) => jsonEncode(e)).toList());

    print('Animales guardados localmente: $animalesJson');
  }

  Future<void> create(AnimalModel animal) async {
    // Llamada al método de inserción en la base de datos SQLite
    final String res = await AnimalSQLiteService.db.insertAnimal(animal);

    // Asigna el ID devuelto por la base de datos al objeto AnimalModel
    animal.id = res as String?;

    // Actualiza la lista de animales desde Firebase
    await load();
  }
}
