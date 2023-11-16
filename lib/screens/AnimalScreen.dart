import 'package:app/models/models.dart';
import 'package:app/services/AnimalService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalScreen extends StatefulWidget {
  AnimalScreen({Key? key, AnimalModel? dataReceived}) {
    reg = dataReceived;
  }

  AnimalModel? reg;

  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  TextEditingController _nombre = TextEditingController();
  TextEditingController _edad = TextEditingController();
  TextEditingController _estado = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final animalService = Provider.of<AnimalServiceLocal>(context);
    bool isNew = true;

    if (widget.reg != null) {
      isNew = false;
      _nombre.text = widget.reg!.nombre;
      _edad.text = widget.reg!.edad.toString();
      _estado.text = widget.reg!.estado;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Animal'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre:'),
              ),
              TextField(
                controller: _edad,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Edad:'),
              ),
              TextField(
                controller: _estado,
                decoration: const InputDecoration(labelText: 'Estado:'),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      asignarAnimal();
                      if (isNew) {
                        await animalService.create(widget.reg!);
                      } else {
                        await animalService.update(widget.reg!);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cerrar'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  asignarAnimal() {
    AnimalModel animal = AnimalModel(
      nombre: _nombre.text,
      edad: int.parse(_edad.text),
      estado: _estado.text,
      id: null,
    );

    widget.reg ??= animal;
    widget.reg!.nombre = _nombre.text;
    widget.reg!.edad = int.parse(_edad.text);
    widget.reg!.estado = _estado.text;
  }
}
