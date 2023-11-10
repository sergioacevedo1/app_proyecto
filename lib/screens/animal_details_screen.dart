import 'package:app/models/AnimalModel.dart';
import 'package:flutter/material.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final AnimalModel dataReceived;

  const AnimalDetailsScreen({Key? key, required this.dataReceived})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${dataReceived.nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${dataReceived.nombre}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Edad: ${dataReceived.edad}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Estado: ${dataReceived.estado}',
                style: const TextStyle(fontSize: 18)),
            // Agrega más detalles según las propiedades de tu modelo
          ],
        ),
      ),
    );
  }
}
