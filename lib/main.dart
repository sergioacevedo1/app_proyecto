import 'package:app/screens/AnimalScreen.dart';
import 'package:app/screens/LocalScreen.dart';
import 'package:app/screens/animal_details_screen.dart';
import 'package:app/screens/screens.dart';
import 'package:app/services/uiChange_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/animal_service.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AnimalService()), // Cambia a tu servicio de animales
        ChangeNotifierProvider(
            create: (_) => UIAnimalService()), // Cambia a tu servicio UI
        // Puedes agregar más providers según sea necesario
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Refugio de Animales',
      initialRoute: 'home',
      routes: {
        'home': (context) => const MenuScreen(),
        'animal' (context) => const AnimalScreen(),
        'animal_local': (context) => const AnimalLocalScreen(),
        
      },
      theme: ThemeData(
          // Configura tu tema según sea necesario
          ),
    );
  }
}
