import 'package:app/models/models.dart';
import 'package:app/services/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalFormScreen extends StatefulWidget {
  const AnimalFormScreen({Key? key}) : super(key: key);

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
              ElevatedButton(
                onPressed: () async {
                  print('Boton presionado');

                  AnimalModel newAnimal = AnimalModel(
                    id: '',
                    nombre: _nombreController.text,
                    edad: int.parse(_edadController.text),
                    estado: _estadoController.text,
                  );
                  print('Nuevo animal creado: $newAnimal');

                  // Guardar localmente utilizando AnimalService
                  final animalService =
                      Provider.of<AnimalService>(context, listen: false);
                  await animalService.create(newAnimal);
                  print('Animal guardado localmente');

                  // Volver a la pantalla anterior
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
