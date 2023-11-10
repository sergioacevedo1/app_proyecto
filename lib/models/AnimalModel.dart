import 'dart:convert';

AnimalModel animalModelFromJson(String str) =>
    AnimalModel.fromJson(json.decode(str));

String animalModelToJson(AnimalModel data) => json.encode(data.toJson());

class AnimalModel {
  int? id;
  String nombre;
  int edad;
  String estado;

  AnimalModel({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.estado,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'edad': edad,
      'estado': estado,
    };
  }

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'],
      nombre: json['nombre'],
      edad: json['edad'],
      estado: json['estado'],
    );
  }
}
