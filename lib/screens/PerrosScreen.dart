import 'package:app/models/Animales.dart';
import 'package:app/screens/DetallesAnimalScreen.dart';
import 'package:flutter/material.dart';

class PerrosScreen extends StatelessWidget {
  final List<Animal> perros;

  const PerrosScreen({super.key, required this.perros});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perros Disponibles para Adopción'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: perros.length,
              itemBuilder: (context, index) {
                final perro = perros[index];
                return ListTile(
                  title: Text(perro.nombre),
                  subtitle: Text(
                      'Edad: ${perro.edad} años - Estado: ${perro.estado}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetallesAnimalScreen(animal: perro),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // logica
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                ),
                const SizedBox(width: 16.0), // Espacio entre botones
                ElevatedButton.icon(
                  onPressed: () {
                    // logica
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
