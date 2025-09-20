import 'package:flutter/material.dart';
import 'package:examen_parcial_uno/constantes.dart' as color;

class PantallaJuego extends StatefulWidget{
    @override
    _PantallaJuegoState createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego>{
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: Text('Memorama'),
            ),
            body: Center(
                child:Text(
                    'Memorama - Partida en curso',
                    style: TextStyle(fontSize: 24),
                ),
            ),
        );
    }
}