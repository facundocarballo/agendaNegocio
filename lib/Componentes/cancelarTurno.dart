// import 'package:flutter/material.dart';
// import 'package:pelu/Estilos/estilos.dart';
// import 'package:pelu/funciones.dart';
// import 'package:pelu/turno.dart';
// import 'package:provider/provider.dart';
// import 'package:pelu/Provider/fecha.dart';

// Future<Map<String, dynamic>> cancelarTurno({
//   BuildContext context,
//   Turno turno,
//   String fechaString,
//   List<Turno> ocupados,
//   List<String> disponibles,
// }) async {
//   FechaProvider fechaProvider = Provider.of<FechaProvider>(context);
//   return await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           content: Container(
//             height: 150,
//             width: 500,
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: [
//                     Spacer(),
//                     Text('$fechaString'),
//                   ],
//                 ),
//                 SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Text(
//                       'Estas seguro de cancelar este turno?',
//                       style: infoPopUp,
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   '${turno.cliente} a las ${turno.horario}',
//                   style: tituloPopUp,
//                 ),
//                 Spacer(),
//                 Container(
//                   width: 500,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: rojo,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ElevatedButton(
//                     style: botonCancelarPopUp,
//                     onPressed: () {
//                       cancelarTurnoFirebase(
//                         turno: turno,
//                         fechaFirebase: fechaString,
//                         turnosOcupados: ocupados,
//                         turnosDisponibles: disponibles,
//                       ).then((map) {
//                         print('retornamos map');
//                         fechaProvider.actualizarTurnos(map: map);
//                       });
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Cancelar Turno', style: textoPopUp),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }
