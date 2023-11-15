import 'package:app/models/models.dart';
import 'package:app/screens/LoadScreen.dart';
import 'package:app/services/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/ListAnimal.dart';

class ApiScreen extends StatelessWidget {
  const ApiScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final animalService = Provider.of<AnimalService>(context);

    if (animalService.isLoading) return const LoadingScreen();

    List<AnimalModel> listAnimales = animalService.animales;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Animales'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await animalService.load();
        },
        child: ListView.builder(
          itemCount: listAnimales.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTitleAnimal(animal: listAnimales[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'crearAnimal');
        },
        child: const Icon(
          Icons.add,
          size: 50,
          color: Colors.red,
        ),
      ),
    );
  }
}
