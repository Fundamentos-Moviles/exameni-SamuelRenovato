import 'package:flutter/material.dart';
import 'package:examen_parcial_uno/constantes.dart' as cons;
import '../cartas/carta.dart';

class CartaJuego extends StatelessWidget {
  final Carta carta;
  final VoidCallback onTap;

  const CartaJuego({
    super.key,
    required this.carta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: cons.ConstantesJuego.flipDuration),
        decoration: BoxDecoration(
          color: carta.volteada || carta.emparejada
            ? cons.blanco
            : const Color.fromARGB(255, 62, 193, 249),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: carta.emparejada
              ? cons.verde
              : cons.gris,
            width: 2,
            ),
          boxShadow: [
            BoxShadow(
              color: cons.negro,
              blurRadius: 4,
              offset: Offset(0, 2),
              ),
            ],
          ),
        child: Center(
          child: carta.volteada || carta.emparejada
              ? Text(
                  carta.value,
                  style: TextStyle(fontSize: 24),
                )
              : Icon(
                  Icons.help_outline,
                  color: cons.blanco,
                  size: 30,
                ),
        ),  
        ),
    );
  }
}