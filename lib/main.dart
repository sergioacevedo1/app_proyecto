import 'package:app/screens/AnimalScreen.dart';
import 'package:app/screens/LocalScreen.dart';
import 'package:app/screens/screens.dart';
import 'package:app/services/AnimalService.dart';
import 'package:app/services/uiChange_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIAnimalService()),
        ChangeNotifierProvider(create: (_) => AnimalServiceLocal()),

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
        'animales': (context) => AnimalScreen(),
        'local': (context) => const AnimalLocalScreen(),
      },
      theme: ThemeData(
        hintColor: Colors.red,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(
            background: Colors.white), // Color de fondo de la aplicación
        // Ajusta otros atributos de tema
      ),
    );
  }
}
