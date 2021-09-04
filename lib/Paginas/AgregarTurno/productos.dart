import 'package:agenda_prueba/Componentes/Cards/cardProducto.dart';
import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgregarTurnoProductos extends StatefulWidget {
  AgregarTurnoProductos({Key key}) : super(key: key);

  @override
  _AgregarTurnoProductosState createState() => _AgregarTurnoProductosState();
}

class _AgregarTurnoProductosState extends State<AgregarTurnoProductos> {
  final estilosTextos = EstilosTexto();
  final colores = Colores();
  @override
  Widget build(BuildContext context) {
    final theWidth = MediaQuery.of(context).size.width - 50;
    final theHeight = MediaQuery.of(context).size.height / 1.41;
    final negocioProvider = Provider.of<NegocioProvider>(context);
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: (theWidth / 2) - 100,
          height: theHeight,
          child: GridView.count(
              crossAxisCount: cantidadCards(width: 250, context: context),
              padding: EdgeInsets.all(5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 250 / 150,
              children: negocioProvider.negocio.productos
                  .map(
                    (producto) => CardProducto(
                      producto: producto,
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }
}
