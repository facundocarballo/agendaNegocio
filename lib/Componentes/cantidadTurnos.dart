import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Provider/fecha.dart';
import 'package:provider/provider.dart';

class CantidadTurnos extends StatefulWidget {
  CantidadTurnos({Key key}) : super(key: key);

  @override
  _CantidadTurnosState createState() => _CantidadTurnosState();
}

class _CantidadTurnosState extends State<CantidadTurnos> {
  @override
  Widget build(BuildContext context) {
    FechaProvider fechaProvider = Provider.of<FechaProvider>(context);
    final cantidadTurnos = fechaProvider.cantidadTurnos;
    final estilosTextos = EstilosTexto();
    if (cantidadTurnos == 0) {
      return Text(
        'No hay cortes todavia',
        style: estilosTextos.negro20Bold,
      );
    } else if (cantidadTurnos == 1) {
      return Text(
        '$cantidadTurnos Corte',
        style: estilosTextos.negro20Bold,
      );
    } else {
      return Text(
        '$cantidadTurnos Cortes',
        style: estilosTextos.negro20Bold,
      );
    }
  }
}
