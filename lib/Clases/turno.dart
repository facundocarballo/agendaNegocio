import 'package:agenda_prueba/Clases/clientes.dart';
import 'package:agenda_prueba/Clases/negocio.dart';

class Turno {
  Cliente cliente;
  String horario;
  List<Producto> productos;
  // Constructor del Turno
  Turno({this.cliente, this.horario, this.productos});
}
