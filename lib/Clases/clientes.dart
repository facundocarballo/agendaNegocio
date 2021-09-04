import 'package:agenda_prueba/Clases/turno.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agenda_prueba/.ConstantesGlobales/constantesGlobales.dart';
import 'package:flutter/material.dart';

class Cliente {
  final String nombre;
  final String apellido;
  final String fotoURL;
  final String alias;
  final String email;
  final String telefono;
  String nombreApellido = '';
  double gastado = 0;
  int visitas = 0;
  double promedio = 0;
  String id = '';

  Cliente({
    this.apellido,
    this.nombre,
    this.fotoURL,
    this.email,
    this.telefono,
    this.alias,
    this.nombreApellido,
    this.gastado,
    this.visitas,
    this.promedio,
    this.id,
  });

  final collectionClientes = FirebaseFirestore.instance.collection('Clientes');
  final constantes = ConstantesGlobales();

  actualizarValoresDelCliente(
      {@required Turno turno, @required bool agregado}) async {
    if (agregado) {
      // ESTE ANDA BIEN.
      final data = obtenerGastadoPromedio(turno: turno, agregado: agregado);
      // Cuando cancelas un turno, se sobreescribe todo el documento con valores nulos.
      final gastado = data['gastado'];
      final promedio = data['promedio'];
      final visitas = data['visitas'];
      this.gastado = gastado;
      this.promedio = promedio;
      this.visitas = visitas.toInt();
      await actualizarValoresDelClienteFunciones(
        turno: turno,
        gastado: gastado,
        promedio: promedio,
        visitas: visitas,
      );
    } else {
      // PROBAR ESTE
      final elCliente = await obtenerCliente(clienteID: turno.cliente.id);
      final data = obtenerGastadoPromedio(turno: turno, agregado: agregado);
      final gastado = data['gastado'];
      // gastado esta en negativo, por eso se suma.
      elCliente.gastado = elCliente.gastado + gastado;
      elCliente.visitas = elCliente.visitas - 1;
      elCliente.promedio = (elCliente.gastado / elCliente.visitas);
      await actualizarValoresDelClienteFuncionesRemove(cliente: elCliente);
    }
  }
}
