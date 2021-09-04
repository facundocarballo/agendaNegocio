import 'package:agenda_prueba/Paginas/Clientes/clientes.dart';
import 'package:agenda_prueba/Paginas/Configuracion/horarios.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Paginas/Disponibles-Ocupados/disponiblesOcupados.dart';
import 'package:agenda_prueba/Paginas/PanelControl/panelControl.dart';
import 'package:agenda_prueba/Provider/paginas.dart';
import 'package:provider/provider.dart';
import 'package:agenda_prueba/Componentes/Header/header.dart';
import 'package:agenda_prueba/Paginas/Disponibles-Ocupados/disponibles.dart';
import 'package:agenda_prueba/Paginas/Disponibles-Ocupados/ocupados.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginasProvider>(context);
    final disponibles = paginaProvider.disponibles;
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(237, 237, 237, 1),
        child: paginaProvider.turnos
            ? Column(
                children: [
                  //Nav
                  Header(),
                  SizedBox(height: 40),
                  // Disponibles y ocupados
                  DisponiblesOcupados(),
                  SizedBox(height: 20),
                  disponibles ? Disponibles() : Ocupados(),
                ],
              )
            : paginaProvider.panelControl
                ? PanelControl()
                : paginaProvider.clientes
                    ? Clientes()
                    : Configuracion(),
      ),
    );
  }
}
