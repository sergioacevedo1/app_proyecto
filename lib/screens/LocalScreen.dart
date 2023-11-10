import 'package:app/models/AnimalModel.dart';
import 'package:app/screens/animal_details_screen.dart';
import 'package:app/services/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalLocalScreen extends StatelessWidget {
  const AnimalLocalScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final animalService = Provider.of<AnimalService>(context);
    animalService.getAllAnimales();
    List<AnimalModel> animales = animalService.animales;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Animales Locales'),
      ),
      body: ListView.builder(
        itemCount: animales.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(animales[index].nombre),
            subtitle: Text('Edad: ${animales[index].edad.toString()}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AnimalDetailsScreen(dataReceived: animales[index]),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    animalService.deleteAnimal(animales[index].id!);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AnimalDetailsScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
