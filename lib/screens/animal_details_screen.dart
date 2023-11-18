import 'package:app/models/AnimalModel.dart';
import 'package:app/screens/AnimalFormScreen.dart';
import 'package:app/services/AnimalService.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final AnimalModel dataReceived;

  const AnimalDetailsScreen({Key? key, required this.dataReceived})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animalService =
        Provider.of<AnimalServiceLocal>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Detalles de ${dataReceived.nombre}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${dataReceived.nombre}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Edad: ${dataReceived.edad}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Estado: ${dataReceived.estado}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _actualizarAnimal(context, dataReceived);
                  },
                  child: Text('Actualizar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _eliminarAnimal(context, dataReceived.id!);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _actualizarAnimal(BuildContext context, AnimalModel animal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimalFormScreen(animal: animal)),
    ).then((_) {
      final animalService =
          Provider.of<AnimalServiceLocal>(context, listen: false);
      animalService.getAllAnimales();
    });
  }

  void _eliminarAnimal(BuildContext context, int animalId) async {
    final animalService =
        Provider.of<AnimalServiceLocal>(context, listen: false);
    await animalService.delete(animalId);

    // Volver a la pantalla anterior
    Navigator.pop(context);
  }
}
