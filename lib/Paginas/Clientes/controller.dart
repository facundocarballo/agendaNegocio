import 'package:agenda_prueba/Clases/clientes.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:agenda_prueba/.ConstantesGlobales/constantesGlobales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Quedan por hacer todas las querys del dropDownList.

class ClientesController extends ChangeNotifier {
  int sortColumnIndex = 0;
  bool isAscending = false;
  bool auxGetClientes = true;
  bool auxBusqueda = false;
  bool auxCrearCliente = false;
  bool ordenar = false;
  List<Cliente> clientes = [];
  List<Cliente> clientesAux = [];
  List<String> dropDownList = [
    'Siempre',
    'Este Año',
    'Ultimos 6 Meses',
    'Ultimos 3 Meses',
    'Este Mes',
    'Elegir Intervalo',
  ];
  String dropDown = 'Ultimos 3 Meses';
  DateTime desde = DateTime.now();
  DateTime hasta = DateTime.now();

  // // Productos...
  // List<Producto> _productos = [];
  // List<Producto> get productos => _productos;

  // getProductos() async {
  //   _productos = await
  // }

  String obtenerFecha({@required DateTime fecha}) {
    return '${fecha.day} - ${fecha.month} - ${fecha.year}';
  }

  filtrarPersonalizado() {
    print('Filtrar Personalizado...');
  }

  cambiarFecha({@required DateTime fecha, @required bool isDesde}) {
    if (isDesde) {
      desde = fecha;
      notifyListeners();
    } else {
      hasta = fecha;
      notifyListeners();
    }
  }

  cambiarDropDown({@required String item}) {
    switch (item) {
      case 'Siempre':
        print('Siempre');
        dropDown = item;
        notifyListeners();
        break;
      case 'Este Año':
        print('Este año');
        dropDown = item;
        notifyListeners();
        break;
      case 'Ultimos 6 Meses':
        print('Ultimos 6 Meses');
        dropDown = item;
        notifyListeners();
        break;
      case 'Ultimos 3 Meses':
        print('Ultimos 3 Meses');
        dropDown = item;
        notifyListeners();
        break;
      case 'Este Mes':
        print('Este Mes');
        dropDown = item;
        notifyListeners();
        break;
      case 'Elegir Intervalo':
        print('Elegir Intervalo');
        dropDown = item;
        notifyListeners();
        break;
      default:
        print('Default');
        break;
    }
  }

  cambiarIsAcending({@required bool ascending, @required int index}) {
    ordenar = true;
    if (index == sortColumnIndex) {
      isAscending = !isAscending;
    } else {
      sortColumnIndex = index;
      isAscending = ascending;
    }
    notifyListeners();
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  Future<List<Cliente>> getClientes() async {
    print('get clientes');
    if (!auxCrearCliente) {
      if (auxBusqueda) {
        auxBusqueda = false;
        return clientes;
      } else {
        if (auxGetClientes) {
          print('leemos');
          clientes = await obtenerClientes();
          // El clientesAux sirve para permanecer el valor de los clientes ante una busqueda y que
          // luego esa busqueda sea cancelada.
          clientesAux = clientes;
          auxGetClientes = false;
          print('?');
          ordenarClientes();
          notifyListeners();
          print('Clientes: $clientes');
          return clientes;
        } else {
          print('no leemos');
          ordenarClientes();
          return clientes;
        }
      }
    } else {
      print('no leemos por haber creado un cliente');
      ordenarClientes();
      return clientes;
    }
  }

  // Crear clientes...

  crearClienteFirestore({@required Cliente cliente}) async {
    final constantes = ConstantesGlobales();
    cliente.nombreApellido = '${cliente.apellido}, ${cliente.nombre}';
    cliente.visitas = 0;
    cliente.gastado = 0;
    cliente.promedio = 0;
    clientes.add(cliente);
    final docReference = FirebaseFirestore.instance
        .collection('Negocio')
        .doc(constantes.documentoPRUEBA)
        .collection('Clientes')
        .doc();
    cliente.id = docReference.id;
    await docReference.set({
      'nombre': cliente.nombre,
      'apellido': cliente.apellido,
      'alias': cliente.alias.isEmpty ? '' : cliente.alias,
      'fotoURL': cliente.fotoURL.isEmpty ? '' : cliente.fotoURL,
      'telefono': cliente.telefono.isEmpty ? '' : cliente.telefono,
      'email': cliente.email.isEmpty ? '' : cliente.email,
      'visitas': cliente.visitas != null ? cliente.visitas : 0,
      'gastado': cliente.gastado != null ? cliente.gastado : 0,
      'promedio': cliente.promedio != null ? cliente.promedio : 0,
    });
    auxCrearCliente = true;
    notifyListeners();
  }

  ordenarClientes() {
    switch (sortColumnIndex) {
      case 0:
        clientes.sort((cliente1, cliente2) => compareString(
            isAscending, cliente1.nombreApellido, cliente2.nombreApellido));
        break;
      case 1:
        clientes.sort((cliente1, cliente2) => compareString(
            isAscending, '${cliente1.gastado}', '${cliente2.gastado}'));
        break;
      case 2:
        clientes.sort((cliente1, cliente2) => compareString(
            isAscending, '${cliente1.visitas}', '${cliente2.visitas}'));
        break;
      case 3:
        clientes.sort((cliente1, cliente2) => compareString(
            isAscending, '${cliente1.promedio}', '${cliente2.promedio}'));
        break;
      default:
        clientes.sort((cliente1, cliente2) => compareString(
            isAscending, cliente1.nombreApellido, cliente2.nombreApellido));
        break;
    }
  }

  buscarClientes({@required String busqueda}) async {
    List<Cliente> nuevos = [];
    for (var cliente in clientes) {
      print('Cliente: ${cliente.nombreApellido}');
      if (cliente.nombreApellido
          .toLowerCase()
          .contains(busqueda.toLowerCase())) {
        print('contiene $busqueda');
        nuevos.add(cliente);
      }
    }
    nuevos.remove(0);
    clientes = nuevos;
    print('clientes: $clientes');
    auxBusqueda = true;
    notifyListeners();
  }

  cancelarBusqueda() {
    clientes = clientesAux;
    notifyListeners();
  }
}
