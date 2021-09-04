import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:provider/provider.dart';
import 'package:agenda_prueba/Provider/paginas.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginasProvider>(context);
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    final estilosTextos = EstilosTexto();
    final estilosBotones = EstilosBotones();
    return Container(
      color: Color.fromRGBO(23, 23, 23, 1),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(width: 30),
          Text(
            negocioProvider.negocio.nombre != null
                ? negocioProvider.negocio.nombre
                : '',
            style: estilosTextos.blanco40Bold,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAturnos();
            },
            child: Text(
              'Inicio',
              style: paginaProvider.turnos
                  ? estilosTextos.negro15
                  : estilosTextos.blanco15,
            ),
            style: paginaProvider.turnos
                ? estilosBotones.blanco
                : estilosBotones.negro,
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irApanelControl();
            },
            child: Text(
              'Turnos por Mes',
              style: paginaProvider.panelControl
                  ? estilosTextos.negro15
                  : estilosTextos.blanco15,
            ),
            style: paginaProvider.panelControl
                ? estilosBotones.blanco
                : estilosBotones.negro,
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAclientes();
            },
            child: Text(
              'Clientes',
              style: paginaProvider.clientes
                  ? estilosTextos.negro15
                  : estilosTextos.blanco15,
            ),
            style: paginaProvider.clientes
                ? estilosBotones.blanco
                : estilosBotones.negro,
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAconfiguracion();
            },
            child: Text(
              'Horarios',
              style: paginaProvider.configuracion
                  ? estilosTextos.negro15
                  : estilosTextos.blanco15,
            ),
            style: paginaProvider.configuracion
                ? estilosBotones.blanco
                : estilosBotones.negro,
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              paginaProvider.irAproductos();
            },
            child: Text(
              'Productos',
              style: paginaProvider.productos
                  ? estilosTextos.negro15
                  : estilosTextos.blanco15,
            ),
            style: paginaProvider.productos
                ? estilosBotones.blanco
                : estilosBotones.negro,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
