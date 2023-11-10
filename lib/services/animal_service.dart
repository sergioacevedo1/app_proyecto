import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
        animalTemp.id = key as int;
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
}
