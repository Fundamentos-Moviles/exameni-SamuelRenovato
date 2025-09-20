import 'package:flutter/material.dart';
import 'dart:math';
import '../cartas/carta.dart';
import '../widgets/carta_juego.dart';
import '../widgets/info_panel.dart';
import '../widgets/config_ventana.dart';
import 'package:examen_parcial_uno/constantes.dart' as cons;

class PantallaJuego extends StatefulWidget{
    @override
    _PantallaJuegoState createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego>{
  int filas = cons.ConstantesJuego.filasInicio;
  int cols = cons.ConstantesJuego.columnasInicio;
  List<Carta> cartas = [];
  List<int> cartasVolteadas = [];
  String autor ='Oscar Samuel Renovato Zapata';
  int movimientos = 0;
  int pares = 0 ; 
  bool enProceso = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniciaJuego();
  }

  void iniciaJuego(){
    cartas.clear();
    cartasVolteadas.clear();
    movimientos = 0; 
    pares = 0;
    enProceso = false;

    int cartasMax = filas * cols ;
    int noParesGanador = cartasMax ~/ 2;
    
    List<String> valoresCarta = [];
    for(int i = 0; i < noParesGanador; i++)
    {
      String value = 
      cons.ConstantesJuego.iconosCarta[i % cons.ConstantesJuego.iconosCarta.length];
      valoresCarta.add(value);
      valoresCarta.add(value);//Crea dos cartas con el mismo valor , es decir un par de cartas
    }

    if(cartasMax % 2 != 0){
      valoresCarta.add(
        cons.ConstantesJuego.iconosCarta[noParesGanador % cons.ConstantesJuego.iconosCarta.length]
        );
    }
    
    //Barajear cartas
    valoresCarta.shuffle(Random());

    //Creacion de cartas a mostrar y asignacion de valores 
    for(int i = 0; i < cartasMax; i++){
      cartas.add(Carta(
        id: i, 
        value:valoresCarta[i],
      ));
    }

    setState(() {}); //actualiza la UI 
  }

  @override
  Widget build(BuildContext context){
      return Scaffold(
          appBar: AppBar(
              title: Text('Memorama- Oscar Samuel Renovato Zapata'),
              backgroundColor: const Color.fromARGB(255, 234, 112, 255),
              actions: [
                IconButton(
                  onPressed: _muestraConfigVentana,
                   icon: Icon(Icons.settings),
                   ),
                IconButton(
                  onPressed: iniciaJuego, 
                  icon: Icon(Icons.refresh),
                  ),
              ],
          ),
          body: Column(
            children: [
              InfoPanel(
                no_movimientos: movimientos, 
                pares: pares, 
                totalPares: (filas * cols)~/2, 
                filas: filas, 
                cols: cols,
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 1,
                    ),
                    itemCount: cartas.length,
                    itemBuilder:(context, index) {
                      return CartaJuego(
                        carta: cartas[index], 
                        onTap:() => volteaCarta(index),
                        );
                    },
                  ),
                ),
              ),
            ],
          ),
      );
  }

  void _muestraConfigVentana() {
    showDialog(
      context: context, 
      builder:(context) => ConfigVentana(
        filasInicio: filas, 
        colsInicio: cols, 
        onApply: (filasNuevo, colsNuevo){
          setState(() {
            filas = filasNuevo;
            cols = colsNuevo;
          });
          iniciaJuego();
        }
      ),
    );
  }
  
  void volteaCarta(int index) {
    if(enProceso||
       cartas[index].volteada||
       cartas[index].emparejada||
       cartasVolteadas.length>=2){
        return;
       }

    setState(() {
      cartas[index].volteada = true;
      cartasVolteadas.add(index);
    });

    if(cartasVolteadas.length ==2){
      movimientos++;
      validaPareja();
    }
  }
  
  void validaPareja() {
    enProceso = true;

    Future.delayed(Duration(milliseconds: cons.ConstantesJuego.matchDelay),(){
      int primeraCarta = cartasVolteadas[0];
      int segundaCarta = cartasVolteadas[1];

      if(cartas[primeraCarta].value == cartas[segundaCarta].value) {
        setState(() {
          cartas[primeraCarta].emparejada = true;
          cartas[segundaCarta].emparejada = true;
          pares++;
        });

        if(pares == (filas * cols )~/2) {
          muestraVictoria();
        }
      } else {
        setState(() {
          cartas[primeraCarta].volteada = false;
          cartas[segundaCarta].volteada = false;
        });
      }

      setState(() {
        cartasVolteadas.clear();
        enProceso = false ;
      });
    });
  }
  
  void muestraVictoria() {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder:(BuildContext context) {
        return AlertDialog(
          title: Text('¡Has ganado!'),
          content: Text('Completaste el juego en $movimientos movimientos 😀'),
          actions: [
            TextButton(
              onPressed:() {
                Navigator.of(context).pop();
                iniciaJuego();
              }, 
              child: Text('Nueva partida'),
            ),
          ],
        );
      },
    );
  }
  
}