import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateRange extends StatefulWidget {
  DateRange({Key key}) : super(key: key);

  @override
  _DateRangeState createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  @override
  Widget build(BuildContext context) {
    final clientesController = Provider.of<ClientesController>(context);
    return Container(
      width: 400,
      height: 70,
      child: Row(
        children: [
          SizedBox(width: 10),
          ElevatedButton(
            style: EstilosBotones().blanco,
            onPressed: () => showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2050),
            ).then(
              (newDate) => clientesController.cambiarFecha(
                  fecha: newDate, isDesde: true),
            ),
            child: Text(
              clientesController.desde == clientesController.hasta
                  ? 'Desde'
                  : clientesController.obtenerFecha(
                      fecha: clientesController.desde),
              style: EstilosTexto().negro15,
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.arrow_forward),
          SizedBox(width: 10),
          ElevatedButton(
            style: EstilosBotones().blanco,
            onPressed: () => showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2050),
            ).then(
              (newDate) => clientesController.cambiarFecha(
                  fecha: newDate, isDesde: false),
            ),
            child: Text(
              clientesController.desde == clientesController.hasta
                  ? 'Hasta'
                  : clientesController.obtenerFecha(
                      fecha: clientesController.hasta),
              style: EstilosTexto().negro15,
            ),
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: () => clientesController.filtrarPersonalizado(),
            child: Text('Filtrar'),
          ),
        ],
      ),
    );
  }
}
