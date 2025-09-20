/// Alumno: Oscar Samuel Renovato Zapata
/// Materia : Fundamentos de Desarrollo Móvil
/// Fecha 19/09/2025

import 'package:flutter/material.dart';
import 'constantes.dart' as color;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title : 'Memorama- Oscar Samuel Renovato Zapata',
      theme: ThemeData(
          primarySwatch: color.azul,
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
