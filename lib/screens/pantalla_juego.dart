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
              title: Text('Memorama'),
              backgroundColor: cons.morado,
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
    print('Carta volteada: ${cartas[index].value}');
  }
}