import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refugio de Animales'),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/perros');
                },
                child: const Text('Perros'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/gatos');
                },
                child: const Text('Gatos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
