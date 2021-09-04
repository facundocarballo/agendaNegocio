import 'package:agenda_prueba/Clases/clientes.dart';
import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:agenda_prueba/Clases/turno.dart';
import 'package:flutter/material.dart';

class TurnosController extends ChangeNotifier {
  Turno _turno = Turno();

  Turno get turno => _turno;

  cargarCliente({@required Cliente cliente}) {
    _turno.cliente = cliente;
    notifyListeners();
  }

  cargarHorario({@required String horario}) {
    _turno.horario = horario;
    notifyListeners();
  }

  cancelarCliente() {
    _turno.cliente = null;
    notifyListeners();
  }

  cargarProducto({@required Producto producto}) {
    if (_turno.productos == null) {
      _turno.productos = [producto];
    } else {
      _turno.productos.add(producto);
    }
    notifyListeners();
  }

  cancelarProducto({@required Producto producto}) {
    _turno.productos.remove(producto);
    notifyListeners();
  }

  limpiarTurno() {
    _turno = Turno();
    notifyListeners();
  }
}
