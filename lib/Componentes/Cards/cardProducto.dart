import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:agenda_prueba/Provider/turnosController.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardProducto extends StatefulWidget {
  final Producto producto;
  CardProducto({Key key, this.producto}) : super(key: key);

  @override
  _CardProductoState createState() => _CardProductoState();
}

class _CardProductoState extends State<CardProducto> {
  final colores = Colores();
  final estilosTextos = EstilosTexto();
  bool seleccionado = false;

  @override
  Widget build(BuildContext context) {
    final turnosProvider = Provider.of<TurnosController>(context);
    final producto = widget.producto;
    return Container(
      width: 250,
      height: 150,
      decoration: BoxDecoration(
        color: colores.negro,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Spacer(),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                '${producto.nombre}',
                style: estilosTextos.blanco15Bold,
              ),
              Spacer(),
              Text(
                '\$${producto.precio}',
                style: estilosTextos.blanco15Bold,
              ),
              SizedBox(width: 10),
            ],
          ),
          Spacer(),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: 280,
            height: 30,
            child: seleccionado
                ? Container(
                    child: ElevatedButton(
                      style: EstilosBotones().verdeRadius,
                      onPressed: () {
                        turnosProvider.cancelarProducto(producto: producto);
                        setState(() {
                          seleccionado = false;
                        });
                      },
                      child: Text(
                        'Seleccionado',
                        style: estilosTextos.blanco15Bold,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      turnosProvider.cargarProducto(
                        producto: producto,
                      );
                      setState(() {
                        seleccionado = true;
                      });
                    },
                    child: Text('Añadir'),
                  ),
          ),
        ],
      ),
    );
  }
}
