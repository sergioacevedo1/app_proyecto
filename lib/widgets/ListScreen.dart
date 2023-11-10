import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/AnimalScreen.dart';
import '../services/animal_service.dart';

class ListTitleAnimal extends StatelessWidget {
  const ListTitleAnimal({Key? key, required this.animal}) : super(key: key);

  final AnimalModel animal;

  @override
  Widget build(BuildContext context) {
    final animalService = Provider.of<AnimalService>(context);

    return ListTile(
      leading: GestureDetector(
        onTap: () {
          animalService.delete(animal.id as AnimalModel);
        },
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AnimalScreen(dataReceived: animal),
            ),
          );
        },
        child: const Icon(Icons.edit, color: Colors.blue),
      ),
      title: Row(
        children: [
          const Text('Nombre: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(animal.nombre),
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Text(
                'Edad: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(animal.edad.toString()),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                'Estado: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(animal.estado),
            ],
          ),
        ],
      ),
    );
  }
}
