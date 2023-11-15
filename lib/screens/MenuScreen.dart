import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:app/screens/AnimalFormScreen.dart';
import 'package:app/screens/LoadScreen.dart';
import 'package:app/services/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'animal_details_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key});

  Future<void> onRefresh(AnimalService service) async {
    await service.load(isUsedLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    final animalService = Provider.of<AnimalService>(context);

    if (animalService.isLoading) return const LoadingScreen();

    List<AnimalModel> listAnimales = animalService.animales;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Animales')),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(animalService),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: listAnimales.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AnimalDetailsScreen(dataReceived: listAnimales[index]),
                  ),
                );
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
                      listAnimales[index].nombre,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Edad: ${listAnimales[index].edad}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Estado: ${listAnimales[index].estado}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnimalFormScreen()),
          );
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
              onPressed: () async {
                await animalService.saveLocally(listAnimales);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Animales guardados localmente')),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> saveAnimalesLocal(List<AnimalModel> animales) async {
    final prefs = await SharedPreferences.getInstance();
    final animalesJson = animales.map((animal) => animal.toJson()).toList();
    await prefs.setStringList(
        'animales', animalesJson.map((e) => jsonEncode(e)).toList());
  }
}
