import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Componentes/cantidadTurnos.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:provider/provider.dart';
import 'package:agenda_prueba/Provider/fecha.dart';
import 'package:agenda_prueba/Provider/paginas.dart';

class DisponiblesOcupados extends StatefulWidget {
  @override
  _DisponiblesOcupadosState createState() => _DisponiblesOcupadosState();
}

class _DisponiblesOcupadosState extends State<DisponiblesOcupados> {
  @override
  Widget build(BuildContext context) {
    FechaProvider fechaProvider = Provider.of<FechaProvider>(context);
    final paginaProvider = Provider.of<PaginasProvider>(context);
    final negocioProvider = Provider.of<NegocioProvider>(context);
    final disponibles = paginaProvider.disponibles;
    final estilosTextos = EstilosTexto();
    final estilosBotones = EstilosBotones();
    if (MediaQuery.of(context).size.width > 600) {
      return Row(
        children: [
          Spacer(),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAdisponibles();
            },
            style: disponibles ? estilosBotones.negro : estilosBotones.blanco,
            child: Text('Disponibles',
                style: disponibles
                    ? estilosTextos.blanco20Bold
                    : estilosTextos.negro20Bold),
          ),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAocupados();
            },
            style: disponibles ? estilosBotones.blanco : estilosBotones.negro,
            child: Text(
              'Ocupados',
              style: disponibles
                  ? estilosTextos.negro20Bold
                  : estilosTextos.blanco20Bold,
            ),
          ),
          SizedBox(height: 25),
          // Cantidad de Cortes
          Spacer(),
          CantidadTurnos(),
          Spacer(),
          // DatePicker
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(237, 237, 237, 1)),
            child: Text(
              obtenerFecha(date: fechaProvider.dateTime),
              style: TextStyle(
                color: Color.fromRGBO(17, 17, 17, 1),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2050),
            ).then(
              (newDate) => fechaProvider.cambiarFecha(
                nuevaFecha: newDate,
                negocio: negocioProvider.negocio,
              ),
            ),
          ),
          Spacer(),
        ],
      );
    } else {
      return Row(
        children: [
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAdisponibles();
            },
            style: disponibles ? estilosBotones.negro : estilosBotones.blanco,
            child: Text(
              'Disponibles',
              style: disponibles
                  ? estilosTextos.blanco20Bold
                  : estilosTextos.negro20Bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAocupados();
            },
            style: disponibles ? estilosBotones.negro : estilosBotones.blanco,
            child: Text(
              'Ocupados',
              style: disponibles
                  ? estilosTextos.blanco20Bold
                  : estilosTextos.negro20Bold,
            ),
          ),
          Spacer(),
        ],
      );
    }
  }
}
