import 'package:flutter/material.dart';

class GatosScreen extends StatelessWidget {
  const GatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Gatos'),
      ),
      body: const Center(
        child: Text('Información sobre gatos'),
      ),
    );
  }
}
