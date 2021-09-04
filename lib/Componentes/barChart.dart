import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Provider/panelControl.dart';
import 'package:provider/provider.dart';

class BarChart extends StatefulWidget {
  final int cantidadTurnos;
  final String fechaString;
  final double width;
  BarChart({
    @required this.cantidadTurnos,
    @required this.fechaString,
    @required this.width,
  });
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height / 1.5;
    final panelProvider = Provider.of<PanelProvider>(context);
    final estilosTextos = EstilosTexto();
    final colores = Colores();
    return Row(
      children: [
        SizedBox(width: 10),
        Container(
          width: widget.width,
          height: maxHeight,
          decoration: BoxDecoration(
            color: colores.negro.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: widget.width,
                height: panelProvider.calcularHeight(
                    turnos: widget.cantidadTurnos, maxHeight: maxHeight),
                decoration: BoxDecoration(
                  color: colores.azul,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.cantidadTurnos.toString(),
                    style: widget.cantidadTurnos == 1
                        ? TextStyle(
                            fontSize: 10,
                            color: colores.blanco,
                            fontWeight: FontWeight.bold,
                          )
                        : estilosTextos.blanco15,
                  ),
                ),
              ),
              Positioned(
                bottom: maxHeight / 2.5,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    widget.fechaString,
                    style: estilosTextos.negro20Bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
