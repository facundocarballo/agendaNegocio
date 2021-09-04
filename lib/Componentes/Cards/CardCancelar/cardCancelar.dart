import 'package:agenda_prueba/funciones.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Componentes/Cards/CardCancelar/cancelar.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Clases/turno.dart';

class CardCancelar extends StatefulWidget {
  final Turno turno;
  final String fechaString;
  CardCancelar({this.fechaString, this.turno});

  @override
  _CardCancelarState createState() => _CardCancelarState();
}

class _CardCancelarState extends State<CardCancelar> {
  @override
  Widget build(BuildContext context) {
    final turno = widget.turno;
    final estilosTextos = EstilosTexto();
    final estilosBotones = EstilosBotones();
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(17, 17, 17, 11),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(17, 17, 17, 11),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
      child: Center(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text('FC'),
              ),
              title: Text(
                turno.cliente.nombreApellido,
                style: estilosTextos.blanco15Bold,
              ),
              subtitle: Text(
                'Alias: ${turno.cliente.alias}',
                style: estilosTextos.blanco15,
              ),
            ),
            Container(
              width: 230,
              height: 2,
              color: Colores().blanco.withOpacity(0.5),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Horario:',
                  style: estilosTextos.blanco15,
                ),
                Spacer(),
                Text(
                  turno.horario,
                  style: estilosTextos.blanco15Bold,
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Productos:',
                  style: estilosTextos.blanco15,
                ),
                Spacer(),
                Text(
                  obtenerNombresProductos(productos: turno.productos),
                  style: obtenerNombresProductos(productos: turno.productos)
                              .length <
                          25
                      ? estilosTextos.blanco15
                      : estilosTextos.blanco10,
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Total:',
                  style: estilosTextos.blanco15,
                ),
                Spacer(),
                Text(
                  '\$ ${obtenerTotalProductos(porductos: turno.productos)}',
                  style: estilosTextos.blanco15Bold,
                ),
                SizedBox(width: 10),
              ],
            ),
            Spacer(),
            Container(
              width: 280,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: ElevatedButton(
                style: estilosBotones.rojoRadius,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cancelar(turno: turno)),
                  );
                },
                child: Text(
                  'CANCELAR',
                  style: estilosTextos.blanco15Bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
