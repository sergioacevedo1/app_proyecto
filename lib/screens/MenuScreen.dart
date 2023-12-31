import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/screens/AnimalFormScreen.dart';
import 'package:app/screens/LoadScreen.dart';
import 'package:app/services/AnimalService.dart';
import 'package:app/services/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'animal_details_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Animales')),
      body: Consumer<AnimalServiceLocal>(
        builder: (context, animalService, child) {
          animalService.getAllAnimales(); // Mueve esta línea dentro del builder

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: animalService.animales.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  String nombreAnimal = animalService.animales[index].nombre;
                  AnimalModel? animalSQLite = await AnimalSQLiteService.db
                      .getAnimalByName(nombreAnimal);
                  if (animalSQLite != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AnimalDetailsScreen(dataReceived: animalSQLite),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        animalService.animales[index].nombre,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Edad: ${animalService.animales[index].edad}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Estado: ${animalService.animales[index].estado}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnimalFormScreen()),
          ).then((_) {
            final animalService =
                Provider.of<AnimalServiceLocal>(context, listen: false);
            animalService.getAllAnimales();
          });
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.black,
        ),
      ),
      persistentFooterButtons: [
        Container(
          color: Colors.red,
          height: 60,
          child: Center(
            child: IconButton(
                icon: const Icon(Icons.save, size: 30, color: Colors.blueGrey),
                onPressed: () async {}),
          ),
        ),
      ],
    );
  }
}
