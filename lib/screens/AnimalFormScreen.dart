import 'package:app/models/models.dart';
import 'package:app/services/AnimalService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalFormScreen extends StatefulWidget {
  final AnimalModel? animal;

  const AnimalFormScreen({Key? key, this.animal}) : super(key: key);

  @override
  _AnimalFormScreenState createState() => _AnimalFormScreenState();
}

class _AnimalFormScreenState extends State<AnimalFormScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Animal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _eliminarAnimal();
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _guardarAnimal();
            },
          ),
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () {
              _actualizarAnimal();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Edad'),
              ),
              TextFormField(
                controller: _estadoController,
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      // ... Resto del código
    );
  }

  _eliminarAnimal() async {
    final animalService =
        Provider.of<AnimalServiceLocal>(context, listen: false);

    int animalId = obtenerAnimalId();
    await animalService.delete(animalId);

    // Notificamos a MenuScreen sobre los cambios
    if (animalService.onAnimalesChanged != null) {
      animalService.onAnimalesChanged!();
    }

    Navigator.pop(context);
  }

  _guardarAnimal() async {
    AnimalModel newAnimal = AnimalModel(
      nombre: _nombreController.text,
      edad: int.parse(_edadController.text),
      estado: _estadoController.text,
    );
    final animalService =
        Provider.of<AnimalServiceLocal>(context, listen: false);
    await animalService.create(newAnimal);
    // Notificamos a MenuScreen sobre los cambios
    if (animalService.onAnimalesChanged != null) {
      animalService.onAnimalesChanged!();
    }
    Navigator.pop(context);
  }

  _actualizarAnimal() async {
    final animalService =
        Provider.of<AnimalServiceLocal>(context, listen: false);
    // Asegúrate de que la lógica para obtener el ID sea correcta
    int animalId = obtenerAnimalId();

    AnimalModel updatedAnimal = AnimalModel(
      id: animalId,
      nombre: _nombreController.text,
      edad: int.parse(_edadController.text),
      estado: _estadoController.text,
    );

    await animalService.update(updatedAnimal);

    // Notificamos a MenuScreen sobre los cambios
    if (animalService.onAnimalesChanged != null) {
      animalService.onAnimalesChanged!();
    }
    Navigator.pop(context);
  }

  int obtenerAnimalId() {
    // Lógica para obtener el ID del animal (puede ser desde algún widget de la pantalla)
    return 1;
  }
}
