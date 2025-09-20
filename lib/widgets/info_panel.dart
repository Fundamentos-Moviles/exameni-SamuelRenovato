import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  final int no_movimientos;
  final int pares;
  final int totalPares;
  final int filas;
  final int cols;

  const InfoPanel({
    super.key,
    required this.no_movimientos,
    required this.pares,
    required this.totalPares,
    required this.filas,
    required this.cols,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('Movimientos', no_movimientos.toString()),
          _buildStatColumn('Coincidencias', '$pares/$totalPares'),
          _buildStatColumn('Cuadrícula', '${filas}x$cols'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}