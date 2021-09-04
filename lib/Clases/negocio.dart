import 'package:agenda_prueba/Clases/disponibilidadHoraria.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agenda_prueba/.ConstantesGlobales/constantesGlobales.dart';
import 'package:flutter/material.dart';

class Usuario {
  String email;
  String fotoURL;
  String nombre;
  Usuario({this.email, this.fotoURL, this.nombre});
}

class Negocio {
  String id;
  String email;
  String fotoURL;
  String nombre;
  String nombreDueno;
  String telefono;
  Dia lunes;
  Dia martes;
  Dia miercoles;
  Dia jueves;
  Dia viernes;
  Dia sabado;
  Dia domingo;
  List<Producto> productos;
  Negocio({
    this.id,
    this.email,
    this.fotoURL,
    this.nombre,
    this.domingo,
    this.jueves,
    this.lunes,
    this.martes,
    this.miercoles,
    this.sabado,
    this.viernes,
    this.productos,
    this.nombreDueno,
    this.telefono,
  });

  final constantes = ConstantesGlobales();
  // Funciones...

  armarNegocio({@required QueryDocumentSnapshot doc}) {
    print('armar negocio');
    final data = doc.data();
    // Obtenemos Informacion:
    final email = data['email'] as String ?? '';
    final fotoURL = data['fotoURL'] as String ?? '';
    final nombre = data['nombre'] as String ?? '';
    this.email = email;
    this.fotoURL = fotoURL;
    this.nombre = nombre;
    this.id = doc.id;
    // Obtenemos los productos:
    final productos = data['productos'] as List<dynamic> ?? [];
    List<Producto> losProductos = [];
    if (productos.isNotEmpty) {
      for (var producto in productos) {
        final nombre = producto['nombre'] as String ?? '';
        final precio = producto['precio'] as String ?? '';
        losProductos.add(Producto(nombre: nombre, precio: precio));
      }
      this.productos = losProductos;
    }
    // Obtener DisponibilidadHoraria:
    for (var i = 0; i < 7; i++) {
      String inicioManana = '';
      String inicioTarde = '';
      String finTarde = '';
      String finManana = '';
      List<String> disponibilidadHoraria = [];
      int duracion = 15;
      final diaString = obtenerDiaString(index: i);
      final dia = data[diaString] as dynamic ?? {};

      if (!dia.isEmpty) {
        inicioManana = dia['inicioManana'] as String ?? '';
        finManana = dia['finManana'] as String ?? '';
        inicioTarde = dia['inicioTarde'] as String ?? '';
        finTarde = dia['finTarde'] as String ?? '';
        duracion = dia['duracion'] as int ?? 0;
        disponibilidadHoraria = obtenerDisponibilidadHorariaXDia(
          inicioManana: inicioManana,
          finManana: finManana,
          inicioTarde: inicioTarde,
          finTarde: finTarde,
          duracion: duracion,
        );
      }
      armarDia(
        i: i,
        diaString: diaString,
        inicioManana: inicioManana,
        finManana: finManana,
        inicioTarde: inicioTarde,
        finTarde: finTarde,
        disponibilidadHoraria: disponibilidadHoraria,
      );
      armarHorariosAperturaCierre(
        index: i,
        abreM: inicioManana,
        abreT: inicioTarde,
        cierraM: finManana,
        cierraT: finTarde,
        duracion: duracion,
      );
    }
  }

  armarHorariosAperturaCierre({
    @required int index,
    @required String abreM,
    @required String abreT,
    @required String cierraM,
    @required String cierraT,
    @required int duracion,
  }) {
    bool trabajoDeCorrido = false;
    bool disponible = true;
    if (abreM == '') {
      disponible = false;
    } else if (abreT == cierraT) {
      trabajoDeCorrido = true;
    }
    switch (index) {
      case 0:
        if (disponible) {
          this.domingo.horariosAperturaCierre.abreM = TimeOfDay(
            hour: int.parse(abreM.split(':')[0]),
            minute: int.parse(abreM.split(':')[1]),
          );
          this.domingo.horariosAperturaCierre.abreT = TimeOfDay(
            hour: int.parse(abreT.split(':')[0]),
            minute: int.parse(abreT.split(':')[1]),
          );
          this.domingo.horariosAperturaCierre.cierraT = TimeOfDay(
            hour: int.parse(cierraT.split(':')[0]),
            minute: int.parse(cierraT.split(':')[1]),
          );
          this.domingo.horariosAperturaCierre.cierraM = TimeOfDay(
            hour: int.parse(cierraM.split(':')[0]),
            minute: int.parse(cierraM.split(':')[1]),
          );
          this.domingo.horariosAperturaCierre.disponible = disponible;
          this.domingo.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        } else {
          this.domingo.horariosAperturaCierre.abreM = TimeOfDay.now();
          this.domingo.horariosAperturaCierre.abreT = TimeOfDay.now();
          this.domingo.horariosAperturaCierre.cierraM = TimeOfDay.now();
          this.domingo.horariosAperturaCierre.cierraT = TimeOfDay.now();
          this.domingo.horariosAperturaCierre.disponible = disponible;
          this.domingo.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        }
        break;
      case 1:
        if (disponible) {
          this.lunes.horariosAperturaCierre.abreM = TimeOfDay(
            hour: int.parse(abreM.split(':')[0]),
            minute: int.parse(abreM.split(':')[1]),
          );
          this.lunes.horariosAperturaCierre.abreT = TimeOfDay(
            hour: int.parse(abreT.split(':')[0]),
            minute: int.parse(abreT.split(':')[1]),
          );
          this.lunes.horariosAperturaCierre.cierraT = TimeOfDay(
            hour: int.parse(cierraT.split(':')[0]),
            minute: int.parse(cierraT.split(':')[1]),
          );
          this.lunes.horariosAperturaCierre.cierraM = TimeOfDay(
            hour: int.parse(cierraM.split(':')[0]),
            minute: int.parse(cierraM.split(':')[1]),
          );
          this.lunes.horariosAperturaCierre.disponible = disponible;
          this.lunes.horariosAperturaCierre.trabajoDeCorrido = trabajoDeCorrido;
        } else {
          this.lunes.horariosAperturaCierre.abreM = TimeOfDay.now();
          this.lunes.horariosAperturaCierre.abreT = TimeOfDay.now();
          this.lunes.horariosAperturaCierre.cierraM = TimeOfDay.now();
          this.lunes.horariosAperturaCierre.cierraT = TimeOfDay.now();
          this.lunes.horariosAperturaCierre.disponible = disponible;
          this.lunes.horariosAperturaCierre.trabajoDeCorrido = trabajoDeCorrido;
        }
        break;
      case 2:
        if (disponible) {
          this.martes.horariosAperturaCierre.abreM = TimeOfDay(
            hour: int.parse(abreM.split(':')[0]),
            minute: int.parse(abreM.split(':')[1]),
          );
          this.martes.horariosAperturaCierre.abreT = TimeOfDay(
            hour: int.parse(abreT.split(':')[0]),
            minute: int.parse(abreT.split(':')[1]),
          );
          this.martes.horariosAperturaCierre.cierraT = TimeOfDay(
            hour: int.parse(cierraT.split(':')[0]),
            minute: int.parse(cierraT.split(':')[1]),
          );
          this.martes.horariosAperturaCierre.cierraM = TimeOfDay(
            hour: int.parse(cierraM.split(':')[0]),
            minute: int.parse(cierraM.split(':')[1]),
          );
          this.martes.horariosAperturaCierre.disponible = disponible;
          this.martes.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        } else {
          this.martes.horariosAperturaCierre.abreM = TimeOfDay.now();
          this.martes.horariosAperturaCierre.abreT = TimeOfDay.now();
          this.martes.horariosAperturaCierre.cierraM = TimeOfDay.now();
          this.martes.horariosAperturaCierre.cierraT = TimeOfDay.now();
          this.martes.horariosAperturaCierre.disponible = disponible;
          this.martes.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        }
        break;
      case 3:
        if (disponible) {
          this.miercoles.horariosAperturaCierre.abreM = TimeOfDay(
            hour: int.parse(abreM.split(':')[0]),
            minute: int.parse(abreM.split(':')[1]),
          );
          this.miercoles.horariosAperturaCierre.abreT = TimeOfDay(
            hour: int.parse(abreT.split(':')[0]),
            minute: int.parse(abreT.split(':')[1]),
          );
          this.miercoles.horariosAperturaCierre.cierraT = TimeOfDay(
            hour: int.parse(cierraT.split(':')[0]),
            minute: int.parse(cierraT.split(':')[1]),
          );
          this.miercoles.horariosAperturaCierre.cierraM = TimeOfDay(
            hour: int.parse(cierraM.split(':')[0]),
            minute: int.parse(cierraM.split(':')[1]),
          );
          this.miercoles.horariosAperturaCierre.disponible = disponible;
          this.miercoles.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        } else {
          this.miercoles.horariosAperturaCierre.abreM = TimeOfDay.now();
          this.miercoles.horariosAperturaCierre.abreT = TimeOfDay.now();
          this.miercoles.horariosAperturaCierre.cierraM = TimeOfDay.now();
          this.miercoles.horariosAperturaCierre.cierraT = TimeOfDay.now();
          this.miercoles.horariosAperturaCierre.disponible = disponible;
          this.miercoles.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        }
        break;
      case 4:
        if (disponible) {
          this.jueves.horariosAperturaCierre.abreM = TimeOfDay(
            hour: int.parse(abreM.split(':')[0]),
            minute: int.parse(abreM.split(':')[1]),
          );
          this.jueves.horariosAperturaCierre.abreT = TimeOfDay(
            hour: int.parse(abreT.split(':')[0]),
            minute: int.parse(abreT.split(':')[1]),
          );
          this.jueves.horariosAperturaCierre.cierraT = TimeOfDay(
            hour: int.parse(cierraT.split(':')[0]),
            minute: int.parse(cierraT.split(':')[1]),
          );
          this.jueves.horariosAperturaCierre.cierraM = TimeOfDay(
            hour: int.parse(cierraM.split(':')[0]),
            minute: int.parse(cierraM.split(':')[1]),
          );
          this.jueves.horariosAperturaCierre.disponible = disponible;
          this.jueves.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        } else {
          this.jueves.horariosAperturaCierre.abreM = TimeOfDay.now();
          this.jueves.horariosAperturaCierre.abreT = TimeOfDay.now();
          this.jueves.horariosAperturaCierre.cierraM = TimeOfDay.now();
          this.jueves.horariosAperturaCierre.cierraT = TimeOfDay.now();
          this.jueves.horariosAperturaCierre.disponible = disponible;
          this.jueves.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        }
        break;
      case 5:
        if (disponible) {
          this.viernes.horariosAperturaCierre.abreM = TimeOfDay(
            hour: int.parse(abreM.split(':')[0]),
            minute: int.parse(abreM.split(':')[1]),
          );
          this.viernes.horariosAperturaCierre.abreT = TimeOfDay(
            hour: int.parse(abreT.split(':')[0]),
            minute: int.parse(abreT.split(':')[1]),
          );
          this.viernes.horariosAperturaCierre.cierraT = TimeOfDay(
            hour: int.parse(cierraT.split(':')[0]),
            minute: int.parse(cierraT.split(':')[1]),
          );
          this.viernes.horariosAperturaCierre.cierraM = TimeOfDay(
            hour: int.parse(cierraM.split(':')[0]),
            minute: int.parse(cierraM.split(':')[1]),
          );
          this.viernes.horariosAperturaCierre.disponible = disponible;
          this.viernes.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        } else {
          this.viernes.horariosAperturaCierre.abreM = TimeOfDay.now();
          this.viernes.horariosAperturaCierre.abreT = TimeOfDay.now();
          this.viernes.horariosAperturaCierre.cierraM = TimeOfDay.now();
          this.viernes.horariosAperturaCierre.cierraT = TimeOfDay.now();
          this.viernes.horariosAperturaCierre.disponible = disponible;
          this.viernes.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        }
        break;
      case 6:
        if (disponible) {
          this.sabado.horariosAperturaCierre.abreM = TimeOfDay(
            hour: int.parse(abreM.split(':')[0]),
            minute: int.parse(abreM.split(':')[1]),
          );
          this.sabado.horariosAperturaCierre.abreT = TimeOfDay(
            hour: int.parse(abreT.split(':')[0]),
            minute: int.parse(abreT.split(':')[1]),
          );
          this.sabado.horariosAperturaCierre.cierraT = TimeOfDay(
            hour: int.parse(cierraT.split(':')[0]),
            minute: int.parse(cierraT.split(':')[1]),
          );
          this.sabado.horariosAperturaCierre.cierraM = TimeOfDay(
            hour: int.parse(cierraM.split(':')[0]),
            minute: int.parse(cierraM.split(':')[1]),
          );
          this.sabado.horariosAperturaCierre.disponible = disponible;
          this.sabado.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        } else {
          this.sabado.horariosAperturaCierre.abreM = TimeOfDay.now();
          this.sabado.horariosAperturaCierre.abreT = TimeOfDay.now();
          this.sabado.horariosAperturaCierre.cierraM = TimeOfDay.now();
          this.sabado.horariosAperturaCierre.cierraT = TimeOfDay.now();
          this.sabado.horariosAperturaCierre.disponible = disponible;
          this.sabado.horariosAperturaCierre.trabajoDeCorrido =
              trabajoDeCorrido;
        }
        break;
      default:
        print("Error en armarHorariosAperturaCierre");
        break;
    }
  }

  obtenerElNegocio({@required String email}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Negocio')
          .where('email', isEqualTo: email)
          .get()
          .then((snapshot) {
        armarNegocio(doc: snapshot.docs.first);
      });
    } catch (e) {
      print('Error, obtenerElNegocio: ${e.toString()}');
      return;
    }
  }

  armarDia({
    @required int i,
    @required String diaString,
    @required String inicioManana,
    @required String finManana,
    @required String inicioTarde,
    @required String finTarde,
    @required List<String> disponibilidadHoraria,
  }) {
    switch (i) {
      case 0:
        this.domingo = Dia(
          dia: diaString,
          inicioManana: inicioManana,
          inicioTarde: inicioTarde,
          finManana: finManana,
          finTarde: finTarde,
          disponibilidadHoraria: disponibilidadHoraria,
        );
        break;
      case 1:
        this.lunes = Dia(
          dia: diaString,
          inicioManana: inicioManana,
          inicioTarde: inicioTarde,
          finManana: finManana,
          finTarde: finTarde,
          disponibilidadHoraria: disponibilidadHoraria,
        );
        break;
      case 2:
        this.martes = Dia(
          dia: diaString,
          inicioManana: inicioManana,
          inicioTarde: inicioTarde,
          finManana: finManana,
          finTarde: finTarde,
          disponibilidadHoraria: disponibilidadHoraria,
        );
        break;
      case 3:
        this.miercoles = Dia(
          dia: diaString,
          inicioManana: inicioManana,
          inicioTarde: inicioTarde,
          finManana: finManana,
          finTarde: finTarde,
          disponibilidadHoraria: disponibilidadHoraria,
        );
        break;
      case 4:
        this.jueves = Dia(
          dia: diaString,
          inicioManana: inicioManana,
          inicioTarde: inicioTarde,
          finManana: finManana,
          finTarde: finTarde,
          disponibilidadHoraria: disponibilidadHoraria,
        );
        break;
      case 5:
        this.viernes = Dia(
          dia: diaString,
          inicioManana: inicioManana,
          inicioTarde: inicioTarde,
          finManana: finManana,
          finTarde: finTarde,
          disponibilidadHoraria: disponibilidadHoraria,
        );
        break;
      case 6:
        this.sabado = Dia(
          dia: diaString,
          inicioManana: inicioManana,
          inicioTarde: inicioTarde,
          finManana: finManana,
          finTarde: finTarde,
          disponibilidadHoraria: disponibilidadHoraria,
        );
        break;
      default:
        break;
    }
  }
}

class Producto {
  String nombre;
  String precio;
  Producto({this.nombre, this.precio});
}

class Dia {
  String dia;
  String duracionTurno;
  String inicioManana;
  String finManana;
  String inicioTarde;
  String finTarde;
  DisponibilidadHoraria horariosAperturaCierre;
  // List<Turno> turnos;
  List<String> disponibilidadHoraria;
  Dia({
    this.dia,
    this.disponibilidadHoraria,
    this.duracionTurno,
    this.horariosAperturaCierre,
    this.finManana,
    this.finTarde,
    this.inicioManana,
    this.inicioTarde,
  });
}
