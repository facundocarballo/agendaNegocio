// ESTO ES UN EJEMPLO, NO LO USAMOS

// import 'package:agenda_prueba/Componentes/scrollableWidget.dart';
// import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
// import 'package:flutter/material.dart';
// import 'package:agenda_prueba/Clases/clientes.dart';

// class TablaClientes extends StatefulWidget {
//   TablaClientes({Key key}) : super(key: key);

//   @override
//   _TablaClientesState createState() => _TablaClientesState();
// }

// class _TablaClientesState extends State<TablaClientes> {
//   @override
//   Widget build(BuildContext context) {
//     return ScrollableWidget(child: buildDataTable());
//   }
// }

// Widget buildDataTable() {
//   final columns = ['Cliente', 'Gastado', 'Visitas', 'Promedio'];
//   final clientes = ClientesController().clientes;
//   final isAcending = ClientesController().isAscending;
//   final sortColumnIndex = ClientesController().sortColumnIndex;
//   return DataTable(
//     sortAscending: isAcending,
//     columns: getColumns(columns: columns),
//     rows: getRows(clientes: clientes),
//     sortColumnIndex: sortColumnIndex,
//   );
// }

// List<DataColumn> getColumns({@required List<String> columns}) {
//   return columns
//       .map(
//         (String column) => DataColumn(label: Text(column), onSort: onSort),
//       )
//       .toList();
// }

// List<DataRow> getRows({@required List<Cliente> clientes}) =>
//     clientes.map((Cliente cliente) {
//       final cells = [
//         cliente.nombreApellido,
//         cliente.gastado,
//         cliente.visitas,
//         cliente.promedio
//       ];
//       return DataRow(cells: getCells(cells: cells));
//     }).toList();

// List<DataCell> getCells({List<dynamic> cells}) =>
//     cells.map((data) => DataCell(Text('$data'))).toList();

// void onSort(int columnIndex, bool ascending) {
//   final controller = ClientesController();
//   final clientes = controller.clientes;
//   if (columnIndex == 0) {
//     clientes.sort((cliente1, cliente2) => compareString(
//         ascending, cliente1.nombreApellido, cliente2.nombreApellido));
//   } else if (columnIndex == 1) {
//     clientes.sort((cliente1, cliente2) =>
//         compareString(ascending, '${cliente1.gastado}', '${cliente2.gastado}'));
//   } else if (columnIndex == 2) {
//     clientes.sort((cliente1, cliente2) =>
//         compareString(ascending, '${cliente1.visitas}', '${cliente2.visitas}'));
//   } else if (columnIndex == 3) {
//     clientes.sort((cliente1, cliente2) => compareString(
//         ascending, '${cliente1.promedio}', '${cliente2.promedio}'));
//   }
//   controller.cambiarIsAcending(ascending: ascending);
//   controller.cambiarSortColumnIndex(index: columnIndex);
// }

// int compareString(bool ascending, String value1, String value2) =>
//     ascending ? value1.compareTo(value2) : value2.compareTo(value1);
