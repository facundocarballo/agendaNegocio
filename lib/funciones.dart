import 'package:agenda_prueba/Clases/clientes.dart';
import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:agenda_prueba/.ConstantesGlobales/constantesGlobales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Clases/turno.dart';

final dataDefault = [
  '9:30',
  '9:45',
  '10:00',
  '10:15',
  '10:30',
  '10:45',
  '11:00',
  '11:15',
  '11:30',
  '11:45',
  '12:00',
  '12:15',
  '12:30',
  '12:45',
  '13:00',
  '13:15',
  '13:30',
  '13:45',
  '14:00',
  '14:15',
  '14:30',
  '14:45',
  '15:00',
  '15:15',
  '15:30',
  '15:45',
  '16:00',
  '16:15',
  '16:30',
  '16:45',
  '17:00',
  '17:15',
  '17:30',
  '17:45',
  '18:00',
  '18:15',
  '18:30',
  '18:45',
  '19:00',
  '19:15',
  '19:30',
  '19:45',
  '20:00'
];

num cantidadCards({@required double width, @required BuildContext context}) {
  final widthPantalla = MediaQuery.of(context).size.width;
  return (widthPantalla / width).truncate();
}

String obtenerNombresProductos({@required List<Producto> productos}) {
  var nombres = [];
  if (productos != null) {
    for (var producto in productos) {
      nombres.add(producto.nombre);
    }
  } else {
    nombres.add('Sin productos...');
  }
  return nombres.join(', ');
}

double obtenerTotalProductos({@required List<Producto> porductos}) {
  var total = 0.0;
  if (porductos != null) {
    for (var producto in porductos) {
      total += int.parse(producto.precio);
    }
  }
  return total;
}

String obtenerFecha({@required DateTime date, bool panelContro = false}) {
  var dia = '';
  var mes = '';
  switch (date.weekday) {
    case 0:
      dia = 'Domingo';
      break;
    case 1:
      dia = 'Lunes';
      break;
    case 2:
      dia = 'Martes';
      break;
    case 3:
      dia = 'Miercoles';
      break;
    case 4:
      dia = 'Jueves';
      break;
    case 5:
      dia = 'Viernes';
      break;
    case 6:
      dia = 'Sabado';
      break;
  }
  switch (date.month) {
    case 1:
      mes = 'Enero';
      break;
    case 2:
      mes = 'Febrero';
      break;
    case 3:
      mes = 'Marzo';
      break;
    case 4:
      mes = 'Abril';
      break;
    case 5:
      mes = 'Mayo';
      break;
    case 6:
      mes = 'Junio';
      break;
    case 7:
      mes = 'Julio';
      break;
    case 8:
      mes = 'Agosto';
      break;
    case 9:
      mes = 'Septiembre';
      break;
    case 10:
      mes = 'Octubre';
      break;
    case 11:
      mes = 'Noviembre';
      break;
    case 12:
      mes = 'Diciembre';
      break;
  }
  if (panelContro) {
    return '$mes del ${date.year}';
  } else {
    return '$dia ${date.day} de $mes del ${date.year}';
  }
}

// FIREBASE

final _db = FirebaseFirestore.instance;
final collectionDias = _db.collection('Dias');

String fechaFirebase({@required DateTime date}) {
  return '${date.day}-${date.month}-${date.year}';
}

Future<Map<String, dynamic>> obtenerOcupadosDisponibles({
  @required DateTime dateTime,
  @required Negocio negocio,
}) async {
  final fechaFS = fechaFirebase(date: dateTime);
  print('Fecha: $fechaFS');
  var losTurnosDisponibles = obtenerDisponiblidadHoraria(
    negocio: negocio,
    dateTime: dateTime,
  );
  Map<String, dynamic> disponiblesOcupados = {
    'disponibles': [],
    'ocupados': [],
  };
  final constantes = ConstantesGlobales();
  List<Turno> losTurnosOcupados = [];
  try {
    await FirebaseFirestore.instance
        .collection('Negocio')
        .doc(constantes.documentoPRUEBA)
        .collection('Dias')
        .doc(fechaFS)
        .get()
        .then((doc) {
      if (doc.exists) {
        final data = doc.data();
        final turnos = data['turnos'] as List<dynamic> ?? [];
        if (turnos.isNotEmpty) {
          for (var turno in turnos) {
            // Armamos el cliente
            final alias = turno['alias'] as String ?? '';
            final clienteID = turno['clienteID'] as String ?? '';
            final fotoURL = turno['fotoURL'] as String ?? '';
            final horario = turno['horario'] as String ?? '';
            final nombreApellido = turno['nombreApellido'] as String ?? '';
            final cliente = Cliente(
              alias: alias,
              id: clienteID,
              fotoURL: fotoURL,
              nombreApellido: nombreApellido,
            );
            List<Producto> losProductos = [];
            final productos = turno['productos'] as List<dynamic> ?? [];
            for (var producto in productos) {
              final nombreProducto = producto['nombre'] as String ?? '';
              final precio = producto['precio'] as String ?? '';
              final elProducto = Producto(
                nombre: nombreProducto,
                precio: precio,
              );
              losProductos.add(elProducto);
            }
            final elTurno = Turno(
                cliente: cliente, horario: horario, productos: losProductos);
            losTurnosOcupados.add(elTurno);
            if (losTurnosDisponibles.contains(horario)) {
              losTurnosDisponibles.remove(horario);
              losTurnosDisponibles.remove(horario);
            }
          }
        }
        // Fin del recorrido de los turnos
        ordenarOcupados(ocupados: losTurnosOcupados);
      } else {
        print('No existe');
        print(disponiblesOcupados);
      }
      disponiblesOcupados['ocupados'] = losTurnosOcupados;
      disponiblesOcupados['disponibles'] = losTurnosDisponibles;
      return disponiblesOcupados;
    });
  } catch (e) {
    print('Error, obtenerDisponiblesOcupados: ${e.toString()}');
    return disponiblesOcupados;
  }
  return disponiblesOcupados;
}

ordenarOcupados({@required List<Turno> ocupados}) {
  for (var i = 0; i < ocupados.length; i++) {
    for (var h = 0; h < ocupados.length - 1; h++) {
      final hor1 = ocupados[h].horario;
      final hor2 = ocupados[h + 1].horario;
      final horario1 = horarioToInt(horario: hor1);
      final horario2 = horarioToInt(horario: hor2);
      if (horario1 > horario2) {
        final aux = ocupados[h];
        ocupados[h] = ocupados[h + 1];
        ocupados[h + 1] = aux;
      }
    }
  }
}

double horarioToInt({@required String horario}) {
  final split = horario.split(':');
  final entero = int.parse(split[0]);
  final decimal = int.parse(split[1]);
  return (entero + (decimal / 100));
}

Future<Cliente> obtenerCliente({@required String clienteID}) async {
  Cliente cliente = Cliente();
  final constantes = ConstantesGlobales();
  try {
    await _db
        .collection('Negocio')
        .doc(constantes.documentoPRUEBA)
        .collection('Clientes')
        .doc(clienteID)
        .get()
        .then((doc) {
      if (doc.exists) {
        final data = doc.data();
        final nombre = data['nombre'] as String ?? '';
        final apellido = data['apellido'] as String ?? '';
        final alias = data['alias'] as String ?? '';
        final email = data['email'] as String ?? '';
        final telefono = data['telefono'] as String ?? '';
        final fotoURL = data['fotoURL'] as String ?? '';
        final gastado = data['gastado'] as double ?? 0;
        final promedio = data['promedio'] as double ?? 0;
        final visitas = data['visitas'] as int ?? 0;
        cliente = Cliente(
          nombre: nombre,
          apellido: apellido,
          alias: alias,
          email: email,
          telefono: telefono,
          fotoURL: fotoURL,
          gastado: gastado,
          promedio: promedio,
          visitas: visitas,
          nombreApellido: '$apellido, $nombre',
          id: clienteID,
        );
      }
    });
    return cliente;
  } catch (e) {
    print('Error, obtenerCliente: ${e.toString()}');
    return cliente;
  }
}

Future<List<Cliente>> obtenerClientes() async {
  print('Se usa?');
  final constantes = ConstantesGlobales();
  List<Cliente> clientes = [];
  try {
    await _db
        .collection('Negocio')
        .doc(constantes.documentoPRUEBA)
        .collection('Clientes')
        .get()
        .then((snapshoot) {
      final docs = snapshoot.docs;
      for (var documento in docs) {
        final data = documento.data();
        final nombre = data['nombre'] as String;
        final apellido = data['apellido'] as String;
        final nombreApellido = '$apellido, $nombre';
        final fotoURL = data['fotoURL'] as String;
        final alias = data['alias'] as String;
        final email = data['email'] as String;
        final telefono = data['telefono'] as String;
        final gastado = data['gastado'] as double;
        final visitas = data['visitas'] as int;
        final promedio = data['promedio'] as double;
        final id = documento.id;
        final cliente = Cliente(
          apellido: apellido,
          nombre: nombre,
          nombreApellido: nombreApellido,
          fotoURL: fotoURL,
          alias: alias,
          email: email,
          telefono: telefono,
          gastado: gastado,
          visitas: visitas,
          promedio: promedio,
          id: id,
        );
        clientes.add(cliente);
      }
    });
  } catch (e) {
    return clientes;
  }
  return clientes;
}

actualizarValoresDelClienteFunciones({
  @required Turno turno,
  @required double gastado,
  @required double promedio,
  @required double visitas,
}) {
  final cliente = turno.cliente;
  final constantes = ConstantesGlobales();
  FirebaseFirestore.instance
      .collection('Negocio')
      .doc(constantes.documentoPRUEBA)
      .collection('Clientes')
      .doc(cliente.id)
      .update({
    'nombre': cliente.nombre,
    'apellido': cliente.apellido,
    'alias': cliente.alias,
    'email': cliente.email,
    'telefono': cliente.telefono,
    'visitas': visitas,
    'gastado': gastado,
    'promedio': promedio,
  });
}

actualizarValoresDelClienteFuncionesRemove({@required Cliente cliente}) async {
  final constantes = ConstantesGlobales();
  try {
    await FirebaseFirestore.instance
        .collection('Negocio')
        .doc(constantes.documentoPRUEBA)
        .collection('Clientes')
        .doc(cliente.id)
        .update({
      'nombre': cliente.nombre,
      'apellido': cliente.apellido,
      'alias': cliente.alias,
      'email': cliente.email,
      'fotoURL': cliente.fotoURL,
      'gastado': cliente.gastado,
      'telefono': cliente.telefono,
      'promedio': cliente.promedio,
      'visitas': cliente.visitas,
    });
  } catch (error) {
    print('Error, actualizarValoresDelClienteFuncionesRemove: $error');
    return;
  }
}

Map<String, double> obtenerGastadoPromedio(
    {@required Turno turno, @required bool agregado}) {
  double gastado = turno.cliente.gastado != null ? turno.cliente.gastado : 0;
  double promedio = 0;
  double visitas =
      turno.cliente.visitas != null ? turno.cliente.visitas.toDouble() : 0;
  if (turno.productos != null) {
    if (agregado) {
      for (var producto in turno.productos) {
        gastado += int.parse(producto.precio);
      }
      promedio = gastado / (visitas + 1);
      visitas += 1;
    } else {
      for (var producto in turno.productos) {
        // El error salia por que gastado tenia el valor null, por lo que no podia restar.
        // Tiene el valor null porque al no ser un turno que estamos generando, no sabe cuanto gasto el cliente.
        // Por eso hay que averiguarlo desde Firebase..
        gastado = gastado - int.parse(producto.precio);
      }
      promedio = gastado / (visitas - 1);
      visitas -= 1;
    }
  }
  return {
    'gastado': gastado,
    'promedio': promedio,
    'visitas': visitas,
  };
}

/*

Future<List<String>> obtenerDisponibles(
    {@required String dia, DateTime dateTime, Negocio negocio}) async {
  /*
  Increiblemente hay un error con el final dataDefault que lo toma como una variable y permite que se realicen cambios en esa constante
  Por otro lado, cuando asignaba turnosDisponibles = dataDefault; a turnosDisponibles le daba el valor de dataDefault, pero si modificaba
  turnosDisponibles, modificaba tambien dataDefautl. Era como si le estuviera pasando la direccion de memoria, es decir una hacia referencia a la otra.
  */
  /*
  Necesitamos que un Provider se encargue cada vez que cambia de fecha que
  ponga en una variable la disponibilidadHoraria de ese dia
  */

  // final fechaFS = fechaFirebase(date: dateTime);
  // var losTurnosDisponibles = obtenerDisponiblidadHoraria(
  //   negocio: negocio,
  //   dateTime: dateTime,
  // );
  // try {
  //   await _db.collection('Dias').doc(fechaFS).get().then((doc) {
  //     final data = doc.data();
  //     final turnos = data['turnos'] as List<dynamic> ?? [];
  //     if (turnos.isNotEmpty) {
  //       for (var turno in turnos) {
  //         final alias = turno['alias'] as String ?? '';
  //         final clienteID = turno['clienteID'] as String ?? '';
  //         final fotoURL = turno['fotoURL'] as String ?? '';
  //         final horario = turno['horario'] as String ?? '';
  //         final nombreApellido = turno['nombreApellido'] as String ?? '';
  //       }
  //     }
  //   });
  // } catch (e) {
  //   print('Error, obtenerDisponibles: ${e.toString()}');
  //   return losTurnosDisponibles;
  // }

  var turnosDisponibles = [
    '9:30',
    '9:45',
    '10:00',
    '10:15',
    '10:30',
    '10:45',
    '11:00',
    '11:15',
    '11:30',
    '11:45',
    '12:00',
    '12:15',
    '12:30',
    '12:45',
    '13:00',
    '13:15',
    '13:30',
    '13:45',
    '14:00',
    '14:15',
    '14:30',
    '14:45',
    '15:00',
    '15:15',
    '15:30',
    '15:45',
    '16:00',
    '16:15',
    '16:30',
    '16:45',
    '17:00',
    '17:15',
    '17:30',
    '17:45',
    '18:00',
    '18:15',
    '18:30',
    '18:45',
    '19:00',
    '19:15',
    '19:30',
    '19:45',
    '20:00'
  ];
  try {
    await _db.collection('Dias').doc(dia).get().then((doc) {
      final data = doc.data();
      final turnos = data['turnos'] as List<dynamic> ?? [];
      if (turnos.isNotEmpty) {
        for (var turno in turnos) {
          final horario = turno['horario'] as String;
          if (turnosDisponibles.contains(horario)) {
            turnosDisponibles.remove(horario);
          }
        }
      }
    });
  } catch (e) {
    return dataDefault;
  }
  return turnosDisponibles;
}
*/

agregarTurnoFirebase(
    {@required Turno turno, @required String fechaFirebase}) async {
  final constantes = ConstantesGlobales();
  final docuemnto = _db
      .collection('Negocio')
      .doc(constantes.documentoPRUEBA)
      .collection('Dias')
      .doc(fechaFirebase);
  await docuemnto.get().then((docSnap) {
    if (docSnap.exists) {
      // Update...
      final data = docSnap.data();
      final turnosDynamic = data['turnos'] as List<dynamic> ?? [];
      final turnos = listDynamicTOlistTurno(lista: turnosDynamic);
      updateDoc(turno: turno, doc: docuemnto, turnos: turnos);
    } else {
      print('Seteamos');
      // Set...
      setDoc(turno: turno, doc: docuemnto);
    }
  });
}

List<Turno> listDynamicTOlistTurno({@required List<dynamic> lista}) {
  List<Turno> turnos = [];
  for (var item in lista) {
    // Turno = Cliente + Horario + Productos

    // Armamos el cliente
    final nombreApellido = item['nombreApellido'] as String ?? '';
    final clienteID = item['clienteID'] as String ?? '';
    final alias = item['alias'] as String ?? '';
    final fotoURL = item['fotoURL'] as String ?? '';
    final cliente = Cliente(
      nombreApellido: nombreApellido,
      id: clienteID,
      alias: alias,
      fotoURL: fotoURL,
    );
    // Armamos los productos
    final productos = item['productos'] as List<dynamic> ?? [];
    List<Producto> losProductos = [];
    if (productos.length > 0) {
      for (var producto in productos) {
        final nombre = producto['nombre'] as String ?? '';
        final precio = producto['precio'] as String ?? '';
        final elProducto = Producto(
          nombre: nombre,
          precio: precio,
        );
        losProductos.add(elProducto);
      }
    }
    // El horario...
    final horario = item['horario'] as String ?? '';
    final turno = Turno(
      cliente: cliente,
      horario: horario,
      productos: losProductos,
    );
    turnos.add(turno);
  }
  return turnos;
}

cancelarTurnoFirebase({
  @required Turno turno,
  @required String fechaFirebase,
  @required List<Turno> turnosOcupados,
  @required List<String> turnosDisponibles,
}) async {
  print('Eliminar el ${turno.cliente}');
  var index = 0;
  List<Turno> _ocupados = turnosOcupados;
  print('Antes de eliminar: $_ocupados');
  while (_ocupados[index].cliente.id != turno.cliente.id &&
      _ocupados[index].horario != turno.horario) {
    print('Entro');
    index++;
  }
  _ocupados.removeAt(index);
  collectionDias
      .doc(fechaFirebase)
      .update({'turnos': arrayToMap(array: _ocupados)});
  List<String> disponibles = turnosDisponibles;
  disponibles.add(turno.horario);
}

updateDoc(
    {@required Turno turno,
    @required DocumentReference doc,
    @required List<Turno> turnos}) async {
  // Antes eran List<dynamic>
  List<Turno> nuevosTurnos = turnos;
  var losProductos = [];
  for (var producto in turno.productos) {
    losProductos.add({
      'nombre': producto.nombre,
      'precio': producto.precio,
    });
  }

  nuevosTurnos.add(turno);

  doc.update({'turnos': deployTurnos(turnos: nuevosTurnos)});
}

List<Map<String, dynamic>> deployTurnos({@required List<dynamic> turnos}) {
  List<Map<String, dynamic>> mapa = [];
  for (var turno in turnos) {
    mapa.add({
      'clienteID': turno.cliente.id,
      'nombreApellido': turno.cliente.nombreApellido,
      'fotoURL': turno.cliente.fotoURL,
      'alias': turno.cliente.alias,
      'productos': deployProductos(productos: turno.productos),
      'horario': turno.horario,
    });
  }
  return mapa;
}

setDoc({@required Turno turno, @required DocumentReference doc}) async {
  print('Nos llego esto: ${turno.cliente.nombreApellido}');
  var losProductos = [];
  for (var producto in turno.productos) {
    print('Producto: ${producto.nombre}');
    losProductos.add({
      'nombre': producto.nombre,
      'precio': producto.precio,
    });
  }
  print('Los Productos: ${losProductos.first['nombre']}');
  try {
    await doc.set({
      'turnos': [
        {
          'horario': turno.horario,
          'alias': turno.cliente.alias,
          'productos': deployProductos(productos: turno.productos),
          'clienteID': turno.cliente.id,
          'nombreApellido': turno.cliente.nombreApellido,
          'fotoURL': turno.cliente.fotoURL,
        }
      ]
    });
  } catch (e) {
    print('ERROR, setDoc(): ${e.toString()}');
  }
}

List<Map<String, String>> deployProductos(
    {@required List<Producto> productos}) {
  List<Map<String, String>> mapa = [];
  for (var producto in productos) {
    mapa.add({
      'nombre': producto.nombre,
      'precio': producto.precio,
    });
  }
  return mapa;
}

List<Map<String, dynamic>> arrayToMap({@required List<Turno> array}) {
  List<Map<String, dynamic>> lista = [];
  for (var turno in array) {
    Map<String, dynamic> mapa = {
      'horario': turno.horario,
      'clienteID': turno.cliente.id,
      'alias': turno.cliente.alias,
      'nombreApellido': turno.cliente.nombreApellido,
      'fotoURL': turno.cliente.fotoURL,
    };
    var losProductos = [];
    for (var producto in turno.productos) {
      losProductos.add({
        'nombre': producto.nombre,
        'precio': producto.precio,
      });
    }
    mapa['productos'] = losProductos;

    lista.add(mapa);
  }
  return lista;
}

String obtenerDiaString({@required int index}) {
  switch (index) {
    case 0:
      return 'domingo';
    case 1:
      return 'lunes';
    case 2:
      return 'martes';
    case 3:
      return 'miercoles';
    case 4:
      return 'jueves';
    case 5:
      return 'viernes';
    case 6:
      return 'sabado';
    default:
      return '';
  }
}

List<String> obtenerDisponibilidadHorariaXDia({
  @required String inicioManana,
  @required String finManana,
  @required String inicioTarde,
  @required String finTarde,
  @required int duracion,
}) {
  List<String> disponibilidadHoraria = [];
  if (inicioManana != '' && finManana != '' && duracion != 0) {
    // Nos fijamos primordialmente solo en estos 3 por si el negocio
    // quiere trabaja de corrido, los horarios de inicio y fin iran a
    // la manana.
    final iM = inicioManana.split(':');
    final fM = finManana.split(':');
    final dispoManana = obtenerCadaHorario(
      inicio: iM,
      fin: fM,
      duracion: duracion,
    );
    disponibilidadHoraria = dispoManana;
  }
  // if (inicioTarde != '' && finTarde != '' && duracion != 0)
  if (inicioTarde != finTarde && duracion != 0) {
    final iT = inicioTarde.split(':');
    final fT = finTarde.split(':');
    final dispoTarde = obtenerCadaHorario(
      inicio: iT,
      fin: fT,
      duracion: duracion,
    );
    // Si existe el horario de tarde, es porque existe el horario de manana
    // Por lo que la disponibilidad de la manana quedara guardada en disponibilidadHoraria.
    disponibilidadHoraria = armarDisponibilidadHoraria(
      manana: disponibilidadHoraria,
      tarde: dispoTarde,
    );
  }

  return disponibilidadHoraria;
}

List<String> obtenerCadaHorario({
  @required List<String> inicio,
  @required List<String> fin,
  @required int duracion,
}) {
  List<String> disponibilidadHoraria = [];
  for (var h = int.parse(inicio[0]); h < int.parse(fin[0]); h++) {
    for (var m = int.parse(inicio[1]); m <= 60; m += duracion) {
      String minutos = '';
      String hora = '$h';
      if (m < 10) {
        minutos = '0$m';
      } else if (m == 60) {
        hora = '${h + 1}';
        minutos = '00';
      } else {
        minutos = '$m';
      }
      final horario = '$hora:$minutos';
      disponibilidadHoraria.add(horario);
    }
  }
  disponibilidadHoraria.remove(0);
  return disponibilidadHoraria;
}

List<String> armarDisponibilidadHoraria({
  @required List<String> manana,
  @required List<String> tarde,
}) {
  List<String> disponibilidadHoraria = [];
  for (var horario in manana) {
    disponibilidadHoraria.add(horario);
  }
  for (var horario in tarde) {
    disponibilidadHoraria.add(horario);
  }
  disponibilidadHoraria.remove(0);
  return disponibilidadHoraria;
}

List<String> obtenerDisponiblidadHoraria(
    {@required Negocio negocio, @required DateTime dateTime}) {
  switch (dateTime.weekday) {
    case 0:
      return negocio.domingo.disponibilidadHoraria;
    case 1:
      return negocio.lunes.disponibilidadHoraria;
    case 2:
      return negocio.martes.disponibilidadHoraria;
    case 3:
      return negocio.miercoles.disponibilidadHoraria;
    case 4:
      return negocio.jueves.disponibilidadHoraria;
    case 5:
      return negocio.viernes.disponibilidadHoraria;
    case 6:
      return negocio.sabado.disponibilidadHoraria;
    default:
      return null;
  }
}
