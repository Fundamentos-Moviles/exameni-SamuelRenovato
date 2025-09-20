import 'package:flutter/material.dart';

const negro = Colors.black;
const gris = Colors.grey;
const blanco = Colors.white;
const azul =Colors.blue;
const morado = Colors.purple;

class ConstantesJuego {
  static const int filasInicio = 4;
  static const int columnasInicio = 5;
  static const int minGridSize = 2;
  static const int maxGridSize = 8;

  //Animaciones y delay para voltear cartas
  static const int flipDuration = 300 ;
  static const int matchDelay = 1000; //en milisegundos

  //Lista de iconos a utilizar en cada carta

  static const List<String> iconosCarta = [
    '🎮', '🎯', '🎲', '🎪', '🎨', '🎭', '🎪', '🎸', '🎹', '🎤',
    '⚽', '🏀', '🏈', '🎾', '🏓', '🏸', '⚾', '🏐', '🏉', '🎱',
    '🍎', '🍊', '🍌', '🍇', '🍓', '🥝', '🍑', '🥭', '🍍', '🥥',
    '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼', '🐨', '🐯',
  ];

}