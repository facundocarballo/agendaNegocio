import 'package:flutter/material.dart';
import 'package:agenda_prueba/Componentes/barChart.dart';
import 'package:agenda_prueba/Provider/panelControl.dart';
import 'package:provider/provider.dart';

class Barras extends StatefulWidget {
  @override
  _BarrasState createState() => _BarrasState();
}

class _BarrasState extends State<Barras> {
  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);
    return FutureBuilder(
      future: panelProvider.obtenerTurnosDelMes(),
      builder: (context, snapshoot) {
        if (snapshoot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (!snapshoot.hasData) {
            return Center(
              child: Text('No hay datos'),
            );
          } else {
            final turnosXdia =
                snapshoot.data as List<Map<String, dynamic>> ?? [];
            final width = panelProvider.cantidadBarras(context: context);
            if (width == 0.0) {
              return Center(
                child: Text('NO HAY DATOS'),
              );
            } else {
              return Row(
                children: turnosXdia
                    .map(
                      (e) => BarChart(
                        cantidadTurnos: e['turnos'],
                        fechaString: e['fecha'],
                        width: width,
                      ),
                    )
                    .toList(),
              );
            }
          }
        }
      },
    );
  }
}
