import 'package:app/models/AnimalModel.dart';
import 'package:flutter/material.dart';
import 'package:app/services/sqlite_service.dart';

class AnimalServiceLocal extends ChangeNotifier {
  List<AnimalModel> animales = [];
  VoidCallback? onAnimalesChanged; // Nuevo callback

  getAllAnimales() async {
    final animales = await AnimalSQLiteService.db.getAllAnimales();
    this.animales = [...animales];
    notifyListeners();
    // Llamamos al callback después de actualizar la lista de animales
    onAnimalesChanged?.call();
  }

  delete(int id) async {
    final int res = await AnimalSQLiteService.db.deleteAnimal(id);
    if (res > 0) {
      getAllAnimales();
      notifyListeners(); // Asegúrate de llamar a notifyListeners()
    }
  }

  create(AnimalModel animal) async {
    final int res = (await AnimalSQLiteService.db.insertAnimal(animal));
    animal.id = res;
    getAllAnimales();
    // Llamamos al callback después de actualizar la lista de animales
    onAnimalesChanged?.call();
    return animal;
  }

  update(AnimalModel animal) async {
    await AnimalSQLiteService.db.updateAnimal(animal);
    getAllAnimales();
    notifyListeners(); // Asegúrate de llamar a notifyListeners()
    return animal;
  }
}
