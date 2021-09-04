import 'package:agenda_prueba/Presentacion/armarHorarios.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';

class Presentacion extends StatefulWidget {
  Presentacion({Key key}) : super(key: key);

  @override
  _PresentacionState createState() => _PresentacionState();
}

class _PresentacionState extends State<Presentacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Crea tu negocio"),
        backgroundColor: Colores().negro,
        foregroundColor: Colores().blanco,
      ),
      body: ArmarHorarios(),
    );
  }
}
