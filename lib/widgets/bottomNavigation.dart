import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/uiChange_service.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  const BottomNavigationBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiService =
        Provider.of<UIAnimalService>(context); // Utiliza el servicio adecuado

    final currentIndex =
        uiService.selectedAnimalOpt; // Utiliza la variable adecuada

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) =>
          uiService.selectedAnimalOpt = index, // Utiliza la variable adecuada
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pets,
            color: Colors.green,
          ), // Cambia el icono según tus necesidades
          label:
              'Lista de Animales', // Cambia la etiqueta según tus necesidades
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: Colors.red,
          ), // Cambia el icono según tus necesidades
          label: 'Agregar Animal', // Cambia la etiqueta según tus necesidades
        ),
      ],
    );
  }
}
