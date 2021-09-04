import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Provider/fecha.dart';
import 'package:agenda_prueba/funciones.dart';
import '../../Componentes/Cards/CardAgregar/cardAgregar.dart';
import '../../funciones.dart';
import 'package:provider/provider.dart';

class Disponibles extends StatefulWidget {
  @override
  _DisponiblesState createState() => _DisponiblesState();
}

class _DisponiblesState extends State<Disponibles> {
  @override
  Widget build(BuildContext context) {
    FechaProvider fechaProvider = Provider.of<FechaProvider>(context);
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    return FutureBuilder(
      future: fechaProvider.getDispo(negocio: negocioProvider.negocio),
      builder: (context, snapshoot) {
        return Expanded(
          child: GridView.count(
            crossAxisCount: cantidadCards(width: 150, context: context),
            padding: EdgeInsets.all(20),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 150 / 120,
            children: fechaProvider.disponibles
                .map(
                  (e) => CardAgregar(
                    horario: e,
                    dia: obtenerFecha(date: fechaProvider.dateTime),
                    fechaFirebase: fechaFirebase(date: fechaProvider.dateTime),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
