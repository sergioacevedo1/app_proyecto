import 'package:flutter/material.dart';

class PerrosScreen extends StatelessWidget {
  const PerrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Perros'),
      ),
      body: const Center(
        child: Text('Información sobre perros'),
      ),
    );
  }
}
