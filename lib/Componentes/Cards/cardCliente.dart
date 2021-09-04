import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';

class CardCliente extends StatefulWidget {
  // Tendriamos que recibir un cliente...
  final String nombre;
  final bool visitas;
  final double width;
  final Function function;

  CardCliente({
    @required this.nombre,
    @required this.visitas,
    @required this.width,
    this.function,
  });

  @override
  _CardClienteState createState() => _CardClienteState();
}

class _CardClienteState extends State<CardCliente> {
  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    final nombre = widget.nombre;
    final visitas = widget.visitas;
    final textos = EstilosTexto();
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: EstilosBotones().negro,
          child: Container(
            width: width,
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      child: Text('FC'),
                    ),
                    SizedBox(width: 20),
                    Text(nombre, style: textos.blanco15Bold),
                    Spacer(),
                    Text('Gasto: 600', style: textos.blanco15Bold),
                    SizedBox(width: 20),
                    visitas
                        ? Text('Visitas: 5', style: textos.blanco15Bold)
                        : SizedBox(width: 0),
                    visitas ? SizedBox(width: 20) : SizedBox(width: 0),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: width - 60,
          height: 2,
          color: Colores().blanco.withOpacity(0.5),
        ),
      ],
    );
  }
}
