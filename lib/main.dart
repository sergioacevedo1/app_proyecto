import 'package:app/listas/ListaAnimal.dart';
import 'package:app/screens/GatosScreen.dart';
import 'package:app/screens/MenuScreen.dart';
import 'package:app/screens/PerrosScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refugio de Animales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Ruta inicial de la aplicación
      routes: {
        '/': (context) => const MenuScreen(),
        '/perros': (context) => PerrosScreen(perros: perros),
        '/gatos': (context) => GatosScreen(
              gatos: gatos,
            ),
      },
    );
  }
}
