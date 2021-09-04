import 'package:agenda_prueba/Clases/disponibilidadHoraria.dart';
import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConfiguaracionController extends ChangeNotifier {
  bool _editar = false;
  List<DisponibilidadHoraria> _disponibilidadHoraria = [
    // Domingo (index = 0)
    DisponibilidadHoraria(
      abreM: TimeOfDay.now(),
      cierraM: TimeOfDay.now(),
      abreT: TimeOfDay.now(),
      cierraT: TimeOfDay.now(),
      duracion: 15,
      disponible: false,
      trabajoDeCorrido: false,
    ),
    // Lunes (index = 1)
    DisponibilidadHoraria(
      abreM: TimeOfDay.now(),
      cierraM: TimeOfDay.now(),
      abreT: TimeOfDay.now(),
      cierraT: TimeOfDay.now(),
      duracion: 15,
      disponible: false,
      trabajoDeCorrido: false,
    ),
    // Martes (index = 2)
    DisponibilidadHoraria(
      abreM: TimeOfDay.now(),
      cierraM: TimeOfDay.now(),
      abreT: TimeOfDay.now(),
      cierraT: TimeOfDay.now(),
      duracion: 15,
      disponible: false,
      trabajoDeCorrido: false,
    ),
    // Miercoles (index = 3)
    DisponibilidadHoraria(
      abreM: TimeOfDay.now(),
      cierraM: TimeOfDay.now(),
      abreT: TimeOfDay.now(),
      cierraT: TimeOfDay.now(),
      duracion: 15,
      disponible: false,
      trabajoDeCorrido: false,
    ),
    // Jueves (index = 4)
    DisponibilidadHoraria(
      abreM: TimeOfDay.now(),
      cierraM: TimeOfDay.now(),
      abreT: TimeOfDay.now(),
      cierraT: TimeOfDay.now(),
      duracion: 15,
      disponible: false,
      trabajoDeCorrido: false,
    ),
    // Viernes (index = 5)
    DisponibilidadHoraria(
      abreM: TimeOfDay.now(),
      cierraM: TimeOfDay.now(),
      abreT: TimeOfDay.now(),
      cierraT: TimeOfDay.now(),
      duracion: 15,
      disponible: false,
      trabajoDeCorrido: false,
    ),
    // Sabado (index = 6)
    DisponibilidadHoraria(
      abreM: TimeOfDay.now(),
      cierraM: TimeOfDay.now(),
      abreT: TimeOfDay.now(),
      cierraT: TimeOfDay.now(),
      duracion: 15,
      disponible: false,
      trabajoDeCorrido: false,
    ),
  ];
  List<String> _listaDuracion = [
    '15 minutos',
    '30 minutos',
    '60 minutos',
    '120 minutos',
  ];
  String _duracion = '15 minutos';

  // Getters
  String get duracion => _duracion;
  List<String> get listaDuracion => _listaDuracion;
  List<DisponibilidadHoraria> get disponibilidadHoraria =>
      _disponibilidadHoraria;
  bool get editar => _editar;

  // Funciones
  bool auxGet = true;

  final _db = FirebaseFirestore.instance;

  cambiarDisponibilidad({@required int index}) {
    if (_disponibilidadHoraria[index].disponible) {
      _disponibilidadHoraria[index].disponible = false;
    } else {
      _disponibilidadHoraria[index].disponible = true;
    }
    notifyListeners();
  }

  cambiarTrabajoDeCorrido({@required int index}) {
    if (_disponibilidadHoraria[index].trabajoDeCorrido) {
      _disponibilidadHoraria[index].trabajoDeCorrido = false;
    } else {
      _disponibilidadHoraria[index].trabajoDeCorrido = true;
    }
    notifyListeners();
  }

  cambiarAbreM({@required TimeOfDay newTime, @required int index}) {
    _disponibilidadHoraria[index].abreM = newTime;
    notifyListeners();
  }

  cambiarCierraM({@required TimeOfDay newTime, @required int index}) {
    _disponibilidadHoraria[index].cierraM = newTime;
    notifyListeners();
  }

  cambiarAbreT({@required TimeOfDay newTime, @required int index}) {
    _disponibilidadHoraria[index].abreT = newTime;
    notifyListeners();
  }

  cambiarCierraT({@required TimeOfDay newTime, @required int index}) {
    _disponibilidadHoraria[index].cierraT = newTime;
    notifyListeners();
  }

  cambiarDuracion({@required int index, @required int nuevaDuracion}) {
    _disponibilidadHoraria[index].duracion = nuevaDuracion;
    notifyListeners();
  }

  cambiarNombre({
    @required String nuevoNombre,
    @required Negocio negocio,
  }) async {
    await FirebaseFirestore.instance
        .collection('Negocio')
        .doc(negocio.id)
        .update({'nombre': nuevoNombre});
  }

  Future<List<DisponibilidadHoraria>> obtenerDisponibilidadHoraria(
      {@required Negocio negocio}) async {
    if (auxGet) {
      await _db.collection('Negocio').doc(negocio.id).get().then((doc) {
        final data = doc.data();
        final domingo = data['domingo'] as dynamic ?? '';
        final lunes = data['lunes'] as dynamic ?? '';
        final martes = data['martes'] as dynamic ?? '';
        final miercoles = data['miercoles'] as dynamic ?? '';
        final jueves = data['jueves'] as dynamic ?? '';
        final viernes = data['viernes'] as dynamic ?? '';
        final sabado = data['sabado'] as dynamic ?? '';

        final listaDias = [
          domingo,
          lunes,
          martes,
          miercoles,
          jueves,
          viernes,
          sabado,
        ];

        _disponibilidadHoraria =
            armarDisponibilidadHoraria(listaDias: listaDias);
      });
      auxGet = false;
      notifyListeners();
    }
    return _disponibilidadHoraria;
  }

  guardarDisponibilidadHoraria({@required Negocio negocio}) async {
    await _db
        .collection('Negocio')
        .doc(negocio.id)
        .update(armarMapaDisponibilidadHoraria());
  }

// Funciones Internas:

  List<DisponibilidadHoraria> armarDisponibilidadHoraria(
      {@required List<dynamic> listaDias}) {
    List<DisponibilidadHoraria> retornoDisponibilidad = [];
    for (var i = 0; i < listaDias.length; i++) {
      if (listaDias[i] != '' && listaDias[i] != Error()) {
        final abreMananaString = listaDias[i]['inicioManana'] as String ?? '';
        final abreTardeString = listaDias[i]['inicioTarde'] as String ?? '';
        final cierraMananaString = listaDias[i]['finManana'] as String ?? '';
        final cierraTardeString = listaDias[i]['finTarde'] as String ?? '';
        final duracion = listaDias[i]['duracion'] as int ?? 15;

        final disponibilidadHoraria = DisponibilidadHoraria(
          abreM: TimeOfDay(
            hour: int.parse(abreMananaString.split(':')[0]),
            minute: int.parse(abreMananaString.split(':')[1]),
          ),
          abreT: TimeOfDay(
            hour: int.parse(abreTardeString.split(':')[0]),
            minute: int.parse(abreTardeString.split(':')[1]),
          ),
          cierraM: TimeOfDay(
            hour: int.parse(cierraMananaString.split(':')[0]),
            minute: int.parse(cierraMananaString.split(':')[1]),
          ),
          cierraT: TimeOfDay(
            hour: int.parse(cierraTardeString.split(':')[0]),
            minute: int.parse(cierraTardeString.split(':')[1]),
          ),
          duracion: duracion,
          disponible: true,
          trabajoDeCorrido: (abreTardeString == cierraTardeString),
        );
        retornoDisponibilidad.add(disponibilidadHoraria);
      } else {
        final disponibilidadHoraria = DisponibilidadHoraria(
          abreM: TimeOfDay.now(),
          cierraM: TimeOfDay.now(),
          abreT: TimeOfDay.now(),
          cierraT: TimeOfDay.now(),
          duracion: 15,
          disponible: false,
          trabajoDeCorrido: false,
        );
        retornoDisponibilidad.add(disponibilidadHoraria);
      }
    }
    return retornoDisponibilidad;
  }

  Map<String, dynamic> armarMapaDisponibilidadHoraria() {
    return {
      'domingo': _disponibilidadHoraria[0].disponible
          ? armarMapaDisponible(
              disponibilidadHoraria: _disponibilidadHoraria[0],
            )
          : '',
      'lunes': _disponibilidadHoraria[1].disponible
          ? armarMapaDisponible(
              disponibilidadHoraria: _disponibilidadHoraria[1],
            )
          : '',
      'martes': _disponibilidadHoraria[2].disponible
          ? armarMapaDisponible(
              disponibilidadHoraria: _disponibilidadHoraria[2],
            )
          : '',
      'miercoles': _disponibilidadHoraria[3].disponible
          ? armarMapaDisponible(
              disponibilidadHoraria: _disponibilidadHoraria[3],
            )
          : '',
      'jueves': _disponibilidadHoraria[4].disponible
          ? armarMapaDisponible(
              disponibilidadHoraria: _disponibilidadHoraria[4],
            )
          : '',
      'viernes': _disponibilidadHoraria[5].disponible
          ? armarMapaDisponible(
              disponibilidadHoraria: _disponibilidadHoraria[5],
            )
          : '',
      'sabado': _disponibilidadHoraria[6].disponible
          ? armarMapaDisponible(
              disponibilidadHoraria: _disponibilidadHoraria[6],
            )
          : '',
    };
  }

  Map<String, dynamic> armarMapaDisponible(
      {@required DisponibilidadHoraria disponibilidadHoraria}) {
    return {
      'duracion': disponibilidadHoraria.duracion,
      'inicioManana':
          disponibilidadHorariaToString(time: disponibilidadHoraria.abreM),
      'inicioTarde':
          disponibilidadHorariaToString(time: disponibilidadHoraria.abreT),
      'finManana':
          disponibilidadHorariaToString(time: disponibilidadHoraria.cierraM),
      'finTarde':
          disponibilidadHorariaToString(time: disponibilidadHoraria.cierraT),
    };
  }

  String disponibilidadHorariaToString({@required TimeOfDay time}) {
    final hora = '${time.hour}';
    final minutos = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    return '$hora:$minutos';
  }
}
