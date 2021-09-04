import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Provider/paginas.dart';
import 'package:provider/provider.dart';

class MobileHeader extends StatefulWidget {
  @override
  _MobileHeaderState createState() => _MobileHeaderState();
}

class _MobileHeaderState extends State<MobileHeader> {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginasProvider>(context);
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    final estilosTextos = EstilosTexto();
    final colores = Colores();
    final estilosBotones = EstilosBotones();
    return Container(
      color: colores.negro,
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          SizedBox(width: 10),
          Text(
            negocioProvider.negocio.nombre != null
                ? negocioProvider.negocio.nombre
                : '',
            style: estilosTextos.blanco15,
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
          // ElevatedButton(
          //   onPressed: () {
          //     paginaProvider.irAconfiguracion()();
          //   },
          //   child: Text(
          //     'Horarios',
          //     style: paginaProvider.configuracion
          //         ? estilosTextos.negro15
          //         : estilosTextos.blanco15,
          //   ),
          //   style: paginaProvider.configuracion
          //       ? estilosBotones.blanco
          //       : estilosBotones.negro,
          // ),
          // SizedBox(width: 10),
          // ElevatedButton(
          //   onPressed: () {
          //     paginaProvider.irAproductos()();
          //   },
          //   child: Text(
          //     'Productos',
          //     style: paginaProvider.productos
          //         ? estilosTextos.negro15
          //         : estilosTextos.blanco15,
          //   ),
          //   style: paginaProvider.productos
          //       ? estilosBotones.blanco
          //       : estilosBotones.negro,
          // ),
          // SizedBox(width: 10),
        ],
      ),
    );
  }
}
