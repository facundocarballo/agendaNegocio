import 'package:agenda_prueba/Paginas/AgregarTurno/clientes.dart';
import 'package:agenda_prueba/Paginas/AgregarTurno/productos.dart';
import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:agenda_prueba/Provider/turnosController.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Provider/fecha.dart';
import 'package:agenda_prueba/Componentes/divider.dart';
import 'package:provider/provider.dart';
import 'package:agenda_prueba/funciones.dart';

class Agregar extends StatefulWidget {
  Agregar();

  @override
  _AgregarState createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  @override
  Widget build(BuildContext context) {
    FechaProvider fechaProvider = Provider.of<FechaProvider>(context);
    TurnosController turnosProvider = Provider.of<TurnosController>(context);
    ClientesController clientesController =
        Provider.of<ClientesController>(context);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final fechaString = obtenerFecha(date: fechaProvider.dateTime);
    final estilosTextos = EstilosTexto();
    final colores = Colores();
    final theWidth = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Turno',
          style: estilosTextos.blanco20Bold,
        ),
        centerTitle: true,
        backgroundColor: colores.negro,
      ),
      backgroundColor: colores.blanco,
      body: Container(
        width: theWidth,
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 40),
                Text(
                  '$fechaString a las ${turnosProvider.turno.horario}',
                  style: estilosTextos.negro20Bold,
                ),
                Spacer(),
                turnosProvider.turno.cliente != null
                    ? turnosProvider.turno.productos != null
                        ? ElevatedButton(
                            onPressed: () async {
                              final fechaFS = fechaFirebase(
                                date: fechaProvider.dateTime,
                              );
                              await fechaProvider.agregarTurnoFirebaseProvider(
                                turno: turnosProvider.turno,
                                fechaFirebase: fechaFS,
                              );
                              clientesController.cancelarBusqueda();
                              turnosProvider.limpiarTurno();
                              Navigator.of(context).pop();
                            },
                            style: EstilosBotones().verdeRadius,
                            child: Container(
                              width: 240,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Añadir Turno',
                                  style: estilosTextos.blanco20Bold,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(width: 0)
                    : SizedBox(width: 0),
                SizedBox(width: 40),
              ],
            ),
            SizedBox(height: 20),
            // Clientes y Productos
            Row(
              children: [
                SizedBox(width: (theWidth / 4) - 125),
                Text(
                  'Seleccionar el Cliente',
                  style: estilosTextos.negro20Bold,
                ),
                SizedBox(width: (theWidth / 2) - 150),
                Text(
                  'Seleccionar los Productos',
                  style: estilosTextos.negro20Bold,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 20),
                Form(
                  key: _formKey,
                  child: AgregarTurnoCliente(
                    horario: turnosProvider.turno.horario,
                  ),
                ),
                Spacer(),
                TheDivider(
                  width: 2,
                  height: MediaQuery.of(context).size.height - 200,
                  color: colores.negro.withOpacity(0.2),
                ),
                Spacer(),
                AgregarTurnoProductos(),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
