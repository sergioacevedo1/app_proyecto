import 'package:app/models/AnimalModel.dart';
import 'package:flutter/material.dart';
import 'package:app/services/sqlite_service.dart';

class AnimalService extends ChangeNotifier {
  List<AnimalModel> animales = [];

  getAllAnimales() async {
    final animales = await AnimalSQLiteService.db.getAllAnimales();
    this.animales = [...animales];
    notifyListeners();
  }

  delete(int id) async {
    final int res = await AnimalSQLiteService.db.deleteAnimal(id);
    if (res > 0) {
      getAllAnimales();
    }
  }

  create(AnimalModel animal) async {
    final int res = await AnimalSQLiteService.db.insertAnimal(animal);
    animal.id = res;
    return animal;
  }

  update(AnimalModel animal) async {
    await AnimalSQLiteService.db.updateAnimal(animal);
    return animal;
  }

  void getAllPerros() {}
}
