import 'package:app/models/AnimalModel.dart';
import 'package:app/models/Animales.dart';
import 'package:flutter/material.dart';

class DetallesAnimalScreen extends StatelessWidget {
  final Animal animal;

  const DetallesAnimalScreen(
      {super.key, required this.animal, required AnimalModel dataReceived});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${animal.nombre}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nombre: ${animal.nombre}'),
          Text('Edad: ${animal.edad} años'),
          Text('Estado: ${animal.estado}'),

          // Agregar más información detallada aquí
        ],
      ),
    );
  }
}
