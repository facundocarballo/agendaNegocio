import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agenda_prueba/.ConstantesGlobales/constantesGlobales.dart';
import 'package:flutter/material.dart';

class PanelProvider extends ChangeNotifier {
  int _month = DateTime.now().month - 1;
  List<Map<String, dynamic>> _turnosXdia = [{}];
  int _turnosXmes = 0;
  int _year = DateTime.now().year;
  bool auxGetMes = true;
  static final _meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  final _db = FirebaseFirestore.instance;

  String get month => _meses[_month];
  int get turnosXmes => _turnosXmes;
  int get year => _year;
  List<String> get meses => _meses;
  List<Map<String, dynamic>> get turnosXdia => _turnosXdia;

  cambiarMes({@required String mes}) {
    switch (mes) {
      case 'Enero':
        _month = 0;
        obtenerTurnosDelMes();
        break;
      case 'Febrero':
        _month = 1;
        obtenerTurnosDelMes();
        break;
      case 'Marzo':
        _month = 2;
        obtenerTurnosDelMes();
        break;
      case 'Abril':
        _month = 3;
        obtenerTurnosDelMes();
        break;
      case 'Mayo':
        _month = 4;
        obtenerTurnosDelMes();
        break;
      case 'Junio':
        _month = 5;
        obtenerTurnosDelMes();
        break;
      case 'Julio':
        _month = 6;
        obtenerTurnosDelMes();
        break;
      case 'Agosto':
        _month = 7;
        obtenerTurnosDelMes();
        break;
      case 'Septiembre':
        _month = 8;
        obtenerTurnosDelMes();
        break;
      case 'Octubre':
        _month = 9;
        obtenerTurnosDelMes();
        break;
      case 'Noviembre':
        _month = 10;
        obtenerTurnosDelMes();
        break;
      case 'Diciembre':
        _month = 11;
        obtenerTurnosDelMes();
        break;
    }
  }

  Future<List<Map<String, dynamic>>> obtenerTurnosDelMes() async {
    final constantes = ConstantesGlobales();
    if (auxGetMes) {
      _turnosXmes = 0;
      _turnosXdia = [];
      try {
        await _db
            .collection('Negocio')
            .doc(constantes.documentoPRUEBA)
            .collection('Dias')
            .get()
            .then((snapshoot) {
          if (snapshoot.docs.isNotEmpty) {
            print('hay docs');
            for (var doc in snapshoot.docs) {
              print('primer for');
              final data = doc.data();
              var cantidadTurnos = 0;
              var split = doc.id.split('-');
              if (split[1] == '${_month + 1}' && split[2] == '$_year') {
                print('entramos el if');
                final turnos = data['turnos'] as List<dynamic> ?? [];
                if (turnos.isNotEmpty) {
                  print('hay turnos');
                  for (var _ in turnos) {
                    print('turno');
                    cantidadTurnos += 1;
                    _turnosXmes += 1;
                  }
                  turnosXdia.add({
                    'fecha': doc.id,
                    'turnos': cantidadTurnos,
                  });
                }
              }
            }
          }
        });
        // Ordenar la lista de turnosXdia
        ordenarTurnosXdia();
        auxGetMes = false;
        notifyListeners();
        return turnosXdia;
      } catch (e) {
        print(e.toString());
        return turnosXdia;
      }
    } else {
      auxGetMes = true;
      return turnosXdia;
    }
  }

  double cantidadBarras({@required BuildContext context}) {
    if (turnosXmes > 0) {
      return ((MediaQuery.of(context).size.width - (20 * turnosXdia.length)) /
          turnosXdia.length);
    } else {
      return 0.0;
    }
  }

  double calcularHeight({@required int turnos, @required double maxHeight}) {
    return ((turnos / 43) * maxHeight);
  }

  ordenarTurnosXdia() {
    //List<Map<String, dynamic>> nuevaLista = _turnosXdia;
    for (var i = 0; i < _turnosXdia.length; i++) {
      for (var h = 0; h < (_turnosXdia.length - 1); h++) {
        final primeraFecha = _turnosXdia[h]['fecha'] as String ?? '';
        final segundaFecha = _turnosXdia[h + 1]['fecha'] as String ?? '';
        final primerNumero = int.parse(primeraFecha.split('-').first);
        final segundoNumero = int.parse(segundaFecha.split('-').first);
        if (primerNumero > segundoNumero) {
          final aux = _turnosXdia[h];
          turnosXdia[h] = turnosXdia[h + 1];
          turnosXdia[h + 1] = aux;
        }
      }
    }
  }
}
