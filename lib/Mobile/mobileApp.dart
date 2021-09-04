import 'package:agenda_prueba/Paginas/Clientes/clientes.dart';
import 'package:agenda_prueba/Paginas/Configuracion/horarios.dart';
import 'package:agenda_prueba/Paginas/Configuracion/productos.dart';
import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Componentes/cantidadTurnos.dart';
import 'package:agenda_prueba/Paginas/Disponibles-Ocupados/disponibles.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Paginas/Disponibles-Ocupados/ocupados.dart';
import 'package:agenda_prueba/Paginas/Disponibles-Ocupados/disponiblesOcupados.dart';
import 'package:agenda_prueba/Paginas/PanelControl/panelControl.dart';
import 'package:agenda_prueba/Provider/fecha.dart';
import 'package:agenda_prueba/Provider/paginas.dart';
import 'package:provider/provider.dart';
import 'package:agenda_prueba/Componentes/Header/mobileHeader.dart';
import 'package:agenda_prueba/funciones.dart';

class MobileApp extends StatefulWidget {
  @override
  _MobileAppState createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginasProvider>(context);
    final fechaProvider = Provider.of<FechaProvider>(context);
    final negocioProvider = Provider.of<NegocioProvider>(context);
    final disponibles = paginaProvider.disponibles;
    final colores = Colores();

    return Scaffold(
      body: Container(
        color: colores.blanco,
        child: paginaProvider.turnos
            ? Column(
                children: [
                  MobileHeader(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(237, 237, 237, 1)),
                        child: Text(
                          obtenerFecha(date: fechaProvider.dateTime),
                          style: TextStyle(
                            color: Color.fromRGBO(17, 17, 17, 1),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        ).then(
                          (newDate) => fechaProvider.cambiarFecha(
                            nuevaFecha: newDate,
                            negocio: negocioProvider.negocio,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Spacer(),
                      CantidadTurnos(),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 5),
                  DisponiblesOcupados(),
                  SizedBox(height: 10),
                  disponibles ? Disponibles() : Ocupados(),
                ],
              )
            : paginaProvider.panelControl
                ? PanelControl()
                : paginaProvider.clientes
                    ? Clientes()
                    : paginaProvider.configuracion
                        ? Configuracion()
                        : AdministrarProductos(),
      ),
    );
  }
}
