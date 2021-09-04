import 'package:agenda_prueba/Componentes/celdas.dart';
import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Tabla extends StatefulWidget {
  Tabla({Key key}) : super(key: key);

  @override
  _TablaState createState() => _TablaState();
}

class _TablaState extends State<Tabla> {
  bool isAscending = false;
  int sortColumnIndex = 0;
  @override
  Widget build(BuildContext context) {
    final clientesController = Provider.of<ClientesController>(context);

    // Funciones...
    List<DataRow> obtenerRows() {
      final clientes = clientesController.clientes;
      List<DataRow> datasRow = [];
      clientes.forEach((cliente) {
        final cells = [
          DataCell(
            Celdas(
              isCliente: true,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      child: Text('${cliente.nombre[0]}${cliente.apellido[0]}'),
                    ),
                    SizedBox(width: 20),
                    Text(cliente.nombreApellido),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          DataCell(
            Celdas(
              isCliente: false,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Text('${cliente.gastado}')),
              ),
            ),
          ),
          DataCell(
            Celdas(
              isCliente: false,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Text('${cliente.visitas}')),
              ),
            ),
          ),
          DataCell(
            Celdas(
              isCliente: false,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Text('${cliente.promedio}')),
              ),
            ),
          ),
        ];
        final dataRow = DataRow(cells: cells);
        datasRow.add(dataRow);
      });
      datasRow.remove(0);
      return datasRow;
    }

    void onSort(int index, bool ascending) {
      print('Ascending: $ascending');
      clientesController.cambiarIsAcending(ascending: ascending, index: index);
    }

    return FutureBuilder(
      future: clientesController.getClientes(),
      builder: (context, snapshoot) {
        return Expanded(
          child: DataTable(
            columns: [
              DataColumn(
                label: Center(child: Text('Cliente')),
                onSort: (ascending, index) => onSort(ascending, index),
              ),
              DataColumn(
                label: Center(child: Text('Gastado')),
                onSort: (ascending, index) => onSort(ascending, index),
              ),
              DataColumn(
                label: Center(child: Text('Visitas')),
                onSort: (ascending, index) => onSort(ascending, index),
              ),
              DataColumn(
                label: Center(child: Text('Promedio')),
                onSort: (ascending, index) => onSort(ascending, index),
              ),
            ],
            rows: obtenerRows(),
            sortAscending: clientesController.isAscending,
            sortColumnIndex: clientesController.sortColumnIndex,
          ),
        );
      },
    );
  }
}
