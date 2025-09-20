class Carta {
  final int id; 
  final String value;
  bool volteada;
  bool emparejada;

  Carta({
    required this.id,
    required this.value,
    this.emparejada = false,
    this.volteada = false,
  });

  Carta copiaCarta({
    int? id,
    String? value,
    bool? volteada,
    bool? emparejada,
  }){
    return Carta(
      id: id ?? this.id,
      value : value ?? this.value,
      volteada: volteada ?? this.volteada,
      emparejada: emparejada ?? this.emparejada,
    );
  }

  @override
  String toString() {
    return 'Carta(id: $id, valor: $value, volteada?: $volteada, emparejada?: $emparejada )' ;
  }
}