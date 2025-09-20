//Clase para una ventana que permite configurar el tablero de manera dinamica

import 'package:flutter/material.dart';
import 'package:examen_parcial_uno/constantes.dart' as cons;

class ConfigVentana extends StatefulWidget {
  final int filasInicio;
  final int colsInicio;
  final Function(int filas, int cols) onApply;

  const ConfigVentana({
    super.key,
    required this.filasInicio,
    required this.colsInicio,
    required this.onApply,
  });

  @override
  _ConfigVentanaState createState() => _ConfigVentanaState();
}

class _ConfigVentanaState extends State<ConfigVentana>{
  late int tempFilas;
  late int tempCols;

  @override
  void initState(){
    super.initState();
    tempFilas = widget.filasInicio;
    tempCols = widget.colsInicio;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(  ///AlertDialog para ventanas emergentes
      title: Text('Ajusta el tamaño del tablero deslizando'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          barraSlider('Filas', tempFilas, (value){
            setState(() {
              tempFilas = value.toInt();
            });
          }),
          SizedBox(height: 20),
          barraSlider('Columnas', tempCols, (value){
            setState(() {
              tempCols = value.toInt();
            });
          }),
          SizedBox(height: 10),
          Text(
            'Total de cartas: ${tempFilas * tempCols}',
            style: TextStyle(
              fontSize: 12,
              color: cons.gris[600],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed:() => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Aceptar'),
          onPressed: (){
            widget.onApply(tempFilas,tempCols);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }


  //Crea un deslizador para cambiar valores
  Widget barraSlider(String label, int value, Function(double) onChanged){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value'),
        Slider(
          value: value.toDouble(),
          min: cons.ConstantesJuego.minGridSize.toDouble(),
          max: cons.ConstantesJuego.maxGridSize.toDouble(),
          divisions: 
          cons.ConstantesJuego.maxGridSize - cons.ConstantesJuego.minGridSize,
          onChanged: onChanged
        ),
      ],
    );
  }

}

