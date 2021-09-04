import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Provider/fecha.dart';
import 'package:provider/provider.dart';
import '../../funciones.dart';
import '../../Componentes/Cards/CardCancelar/cardCancelar.dart';

class Ocupados extends StatefulWidget {
  Ocupados();
  @override
  _OcupadosState createState() => _OcupadosState();
}

class _OcupadosState extends State<Ocupados> {
  @override
  Widget build(BuildContext context) {
    FechaProvider fechaProvider = Provider.of<FechaProvider>(context);
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    return FutureBuilder(
        future: fechaProvider.getOcu(negocio: negocioProvider.negocio),
        builder: (context, snapshoot) {
          return Expanded(
            child: fechaProvider.ocupados.isNotEmpty
                ? GridView.count(
                    crossAxisCount: cantidadCards(width: 250, context: context),
                    padding: EdgeInsets.all(20),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: (250 / 200),
                    children: fechaProvider.ocupados
                        .map((ocupado) => CardCancelar(
                              turno: ocupado,
                              fechaString:
                                  fechaFirebase(date: fechaProvider.dateTime),
                            ))
                        .toList(),
                  )
                : Center(
                    child: Text('Todavia no hay turnos para esta fecha'),
                  ),
          );
        });
  }
}
