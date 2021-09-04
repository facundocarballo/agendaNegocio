import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:agenda_prueba/Provider/turnosController.dart';
import 'package:agenda_prueba/Paginas/Clientes/agregarCliente.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AgregarTurnoCliente extends StatefulWidget {
  final String horario;
  AgregarTurnoCliente({Key key, this.horario}) : super(key: key);

  @override
  _AgregarTurnoClienteState createState() => _AgregarTurnoClienteState();
}

class _AgregarTurnoClienteState extends State<AgregarTurnoCliente> {
  final TextEditingController _clienteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final clientesController = Provider.of<ClientesController>(context);
    TurnosController turnoProvider = Provider.of<TurnosController>(context);
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    final theWidth = MediaQuery.of(context).size.width - 50;
    final theHeight = MediaQuery.of(context).size.height / 4;
    final colores = Colores();

    return Column(
      children: [
        SizedBox(height: 10),
        turnoProvider.turno.cliente != null
            ? Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        turnoProvider.cancelarCliente();
                      },
                      child: Icon(Icons.clear),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Cliente Seleccionado: ${turnoProvider.turno.cliente.nombreApellido}',
                  ),
                ],
              )
            : SizedBox(width: 0),
        SizedBox(height: 10),
        // Buscador de Clientes
        Container(
          width: (theWidth / 2) - 100,
          height: 40,
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Buscar Cliente',
              suffixIcon: GestureDetector(
                child: Icon(
                  Icons.clear,
                  color: colores.negro,
                ),
                onTap: () {
                  _clienteController.clear();
                  clientesController.cancelarBusqueda();
                },
              ),
            ),
            onFieldSubmitted: (value) {
              clientesController.buscarClientes(busqueda: value);
            },
            controller: _clienteController,
          ),
        ),
        SizedBox(height: 20),
        // Botones Añadir Turno y Crear Cliente
        Container(
          width: (theWidth / 2) - 100,
          height: 40,
          child: Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgregarCliente(),
                    ),
                  );
                },
                child: Text('Crear Cliente'),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
        // Contenedor de Clientes
        SizedBox(height: 10),
        Container(
          width: (theWidth / 2) - 100,
          height: theHeight,
          child: FutureBuilder(
            future: clientesController.getClientes(
              negocio: negocioProvider.negocio,
            ),
            builder: (context, snapshoot) {
              if (snapshoot.hasError) {
                return Center(
                  child: Text(
                      'Something went wrong, ${snapshoot.error.toString()}'),
                );
              } else {
                return ListView(
                  children: clientesController.clientes
                      .map((cliente) => ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                  '${cliente.nombre[0]}${cliente.apellido[0]}'),
                            ),
                            title: Text(cliente.nombreApellido),
                            onTap: () {
                              turnoProvider.cargarCliente(
                                cliente: cliente,
                              );
                            },
                          ))
                      .toList(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
