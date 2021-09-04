import 'package:flutter/material.dart';

class PaginasProvider extends ChangeNotifier {
  bool _panelControl = false;
  bool _turnos = true;
  bool _disponibles = true;
  bool _clientes = false;
  bool _configuracion = false;
  bool _productos = false;
  int paginas = 0;

  bool get panelControl => _panelControl;
  bool get turnos => _turnos;
  bool get disponibles => _disponibles;
  bool get clientes => _clientes;
  bool get configuracion => _configuracion;
  bool get productos => _productos;

  irAturnos() {
    if (!turnos) {
      paginas = 0;
      _turnos = true;
      _panelControl = false;
      _configuracion = false;
      _clientes = false;
      _productos = false;
      notifyListeners();
    }
  }

  irApanelControl() {
    if (!_panelControl) {
      paginas = 1;
      _panelControl = true;
      _turnos = false;
      _configuracion = false;
      _clientes = false;
      _productos = false;
      notifyListeners();
    }
  }

  irAclientes() {
    if (!_clientes) {
      paginas = 2;
      _clientes = true;
      _configuracion = false;
      _panelControl = false;
      _turnos = false;
      _productos = false;
      notifyListeners();
    }
  }

  irAconfiguracion() {
    if (!_configuracion) {
      paginas = 3;
      _configuracion = true;
      _clientes = false;
      _panelControl = false;
      _turnos = false;
      _productos = false;
      notifyListeners();
    }
  }

  irAproductos() {
    if (!_productos) {
      paginas = 4;
      _productos = true;
      _clientes = false;
      _panelControl = false;
      _turnos = false;
      _configuracion = false;
      notifyListeners();
    }
  }

  irAdisponibles() {
    if (!_disponibles) {
      _disponibles = true;
      notifyListeners();
    }
  }

  irAocupados() {
    if (_disponibles) {
      _disponibles = false;
      notifyListeners();
    }
  }
}
