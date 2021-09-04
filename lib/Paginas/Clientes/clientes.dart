import 'package:agenda_prueba/Componentes/Header/header.dart';
import 'package:agenda_prueba/Componentes/Header/mobileHeader.dart';
import 'package:agenda_prueba/Paginas/Clientes/agregarCliente.dart';
import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:agenda_prueba/Paginas/Clientes/dateRange.dart';
import 'package:agenda_prueba/Paginas/Clientes/dropdown.dart';
import 'package:agenda_prueba/Paginas/Clientes/tabla.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Clientes extends StatefulWidget {
  Clientes({Key key}) : super(key: key);

  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  final busquedaClientesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final botones = EstilosBotones();
    final textos = EstilosTexto();
    final clientesController = Provider.of<ClientesController>(context);

    return Container(
      child: Column(
        children: [
          width > 600 ? Header() : MobileHeader(),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 40),
              Container(
                width: MediaQuery.of(context).size.width / 6,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colores().blanco,
                ),
                child: TextFormField(
                  controller: busquedaClientesController,
                  decoration: InputDecoration(
                    hintText: 'Buscar Cliente',
                    suffixIcon: busquedaClientesController.text.isNotEmpty
                        ? GestureDetector(
                            child: Icon(
                              Icons.clear,
                              color: Colores().negro,
                            ),
                            onTap: () {
                              busquedaClientesController.clear();
                              clientesController.cancelarBusqueda();
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Colores().negro,
                    ),
                  ),
                  onFieldSubmitted: (busqueda) {
                    print(busqueda);
                    clientesController.buscarClientes(busqueda: busqueda);
                  },
                ),
              ),
              Spacer(),
              //SizedBox(width: 40),
              // DropDown
              Center(child: DropDown()),
              clientesController.dropDown == 'Elegir Intervalo'
                  ? DateRange()
                  : SizedBox(height: 0),
              Spacer(),
              Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  style: botones.negro,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgregarCliente(),
                      ),
                    );
                  },
                  child: Text('+ Nuevo Cliente', style: textos.blanco15Bold),
                ),
              ),
              SizedBox(width: 40),
            ],
          ),
          SizedBox(height: 40),
          Tabla(),
        ],
      ),
    );
  }
}
