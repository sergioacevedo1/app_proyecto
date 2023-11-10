import 'package:app/models/Animales.dart';
import 'package:app/screens/DetallesAnimalScreen.dart';
import 'package:flutter/material.dart';

class GatosScreen extends StatelessWidget {
  final List<Animal> gatos;

  const GatosScreen({super.key, required this.gatos});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gatos Disponibles para Adopción'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: gatos.length,
              itemBuilder: (context, index) {
                final gato = gatos[index];
                return ListTile(
                  title: Text(gato.nombre),
                  subtitle:
                      Text('Edad: ${gato.edad} años - Estado: ${gato.estado}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetallesAnimalScreen(animal: gato),
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
                const SizedBox(width: 16.0),
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
