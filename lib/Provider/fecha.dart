import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:agenda_prueba/Clases/turno.dart';

// Podriamos hacerlo mas eficiente ya que cada vez que leemos disponibles u ocupados
// Estamos recibiendo ambos datos. Por lo que nos podriamos ahorrar una llamada.

class FechaProvider extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  List<String> _disponibilidadHoraria = [];
  List<String> _disponibles = [];
  List<Turno> _ocupados = [];
  int _cantidadTurnos;

  DateTime get dateTime => _dateTime;
  List<String> get disponibilidadHoraria => _disponibilidadHoraria;
  List<String> get disponibles => _disponibles;
  List<Turno> get ocupados => _ocupados;
  int get cantidadTurnos => (_cantidadTurnos);
  bool auxGetDispo = true;
  bool auxGetOcu = true;
  bool auxCrearCancelar = false;

  Future<List<String>> getDispo({@required Negocio negocio}) async {
    print('getDispo');
    /*
    Necesitamos un aux para poder notificarle a los widgtes que estan escuchando
    las variables de esta clase, SOLO cuando ocurre un cambio. Sin el aux 
    entrariamos en un bucle infinito que constantemente estaria leyendo los datos
    de Firebase y avisandole a los Widgtes.
    Cuando el aux esta en 'true' quiere decir que es necesario leer de Firebase
    y luego notificarle a los widgets de que puede haber un cambio para que lo 
    muestren en pantalla. Cuando esta en 'false' no lee de firebase porque esta
    realizando la lectura solo y exclusivamente para refrescar a los Widgets.

    (Cuando esta en false no hace nada, solo refresca).
    */
    if (auxCrearCancelar) {
      // Como ya actualizamos los valores de _disponibles, _ocupados y _cantidadTurnos no hace falta volver a leer los
      // documentos devuelta.
      auxCrearCancelar = false;
      return _disponibles;
    } else if (auxGetDispo) {
      final disponiblesOcupados = await obtenerOcupadosDisponibles(
        dateTime: dateTime,
        negocio: negocio,
      );
      _ocupados = disponiblesOcupados['ocupados'] as List<Turno> ?? [];
      _disponibles = disponiblesOcupados['disponibles'] as List<String> ?? [];
      _cantidadTurnos = _ocupados.length;
      auxGetDispo = false;
      notifyListeners();
      return _disponibles;
    } else {
      auxGetDispo = true;
      return _disponibles;
    }
  }

  Future<List<Turno>> getOcu({@required Negocio negocio}) async {
    // Necesitamos un aux al igual que en getDispo()
    if (auxCrearCancelar) {
      // Como ya actualizamos los valores de _disponibles, _ocupados y _cantidadTurnos no hace falta volver a leer los
      // documentos devuelta.
      auxCrearCancelar = false;
      return _ocupados;
    } else if (auxGetOcu) {
      print('leemos ocupados');
      final disponiblesOcupados = await obtenerOcupadosDisponibles(
          dateTime: _dateTime, negocio: negocio);
      _ocupados = disponiblesOcupados['ocupados'] as List<Turno> ?? [];
      _disponibles = disponiblesOcupados['disponibles'] as List<String> ?? [];

      auxGetOcu = false;
      notifyListeners();
      return _ocupados;
    } else {
      auxGetOcu = true;
      return _ocupados;
    }
  }

  cambiarFecha(
      {@required DateTime nuevaFecha, @required Negocio negocio}) async {
    if (nuevaFecha != null) {
      _dateTime = nuevaFecha;
      final disponiblesOcupados = await obtenerOcupadosDisponibles(
        dateTime: dateTime,
        negocio: negocio,
      );
      _ocupados = disponiblesOcupados['ocupados'] as List<Turno> ?? [];
      _disponibles = disponiblesOcupados['disponibles'] as List<String> ?? [];
      _cantidadTurnos = _ocupados.length;
      notifyListeners();
    }
  }

  agregarTurnoFirebaseProvider({
    @required Turno turno,
    @required String fechaFirebase,
    @required Negocio negocio,
  }) async {
    final docuemnto = FirebaseFirestore.instance
        .collection('Negocio')
        .doc(negocio.id)
        .collection('Dias')
        .doc(fechaFirebase);
    await docuemnto.get().then((docSnap) async {
      if (docSnap.exists) {
        // Update...
        final data = docSnap.data();
        final turnosDynamic = data['turnos'] as List<dynamic> ?? [];
        final turnos = listDynamicTOlistTurno(lista: turnosDynamic);
        await updateDoc(turno: turno, doc: docuemnto, turnos: turnos);
      } else {
        // Set...
        await setDoc(turno: turno, doc: docuemnto);
      }
      _ocupados.add(turno);
      ordenarOcupados(ocupados: _ocupados);
      _disponibles.remove(turno.horario);
      _cantidadTurnos++;
      auxCrearCancelar = true;
      // Actualizar valores del cliente
      await turno.cliente.actualizarValoresDelCliente(
        turno: turno,
        agregado: true,
        negocio: negocio,
      );
      notifyListeners();
    });
  }

  cancelarTurnoFirebaseProvider({
    @required Turno turno,
    @required String fechaFirebase,
    @required Negocio negocio,
  }) async {
    var index = 0;
    List<Turno> ocupados = _ocupados;
    while (ocupados[index].cliente != turno.cliente &&
        ocupados[index].horario != turno.horario) {
      index++;
    }
    _ocupados.removeAt(index);
    ordenarOcupados(ocupados: _ocupados);
    FirebaseFirestore.instance
        .collection('Negocio')
        .doc(negocio.id)
        .collection('Dias')
        .doc(fechaFirebase)
        .update({'turnos': arrayToMap(array: ocupados)});

    _ocupados = ocupados;
    _disponibles.add(turno.horario);
    _cantidadTurnos--;
    auxCrearCancelar =
        true; // Avisamos que ya actualizamos, no hace falta leer.
    // Actualizar a los clientes que le cancelamos un turno.
    await turno.cliente.actualizarValoresDelCliente(
      turno: turno,
      agregado: false,
      negocio: negocio,
    );

    notifyListeners();
  }
}
