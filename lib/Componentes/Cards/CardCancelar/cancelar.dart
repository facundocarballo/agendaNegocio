import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Provider/fecha.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:agenda_prueba/Clases/turno.dart';
import 'package:provider/provider.dart';

class Cancelar extends StatefulWidget {
  final Turno turno;
  Cancelar({this.turno});

  @override
  _CancelarState createState() => _CancelarState();
}

class _CancelarState extends State<Cancelar> {
  @override
  Widget build(BuildContext context) {
    FechaProvider fechaProvider = Provider.of<FechaProvider>(context);
    final fechaString = obtenerFecha(date: fechaProvider.dateTime);
    final fechaFire = fechaFirebase(date: fechaProvider.dateTime);
    final estilosTextos = EstilosTexto();
    final colores = Colores();
    final estilosBotones = EstilosBotones();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancelar Turno', style: estilosTextos.blancoBold),
        backgroundColor: colores.negro,
        centerTitle: true,
      ),
      backgroundColor: colores.blanco,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Row(
              children: [
                Spacer(),
                Text(
                  '$fechaString',
                  style: estilosTextos.negro35BoldItalic,
                ),
                SizedBox(width: 40),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 40),
                Text(
                  'Estas seguro de cancelar este turno? ${widget.turno.cliente.nombreApellido} a las ${widget.turno.horario}',
                  style: estilosTextos.negro20Bold,
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 60),
            Row(
              children: [
                SizedBox(width: 40),
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colores.rojo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style: estilosBotones.rojo,
                    onPressed: () async {
                      await fechaProvider.cancelarTurnoFirebaseProvider(
                        turno: widget.turno,
                        fechaFirebase: fechaFire,
                      );
                      Navigator.of(context).pop();
                    },
                    child:
                        Text('Cancelar Turno', style: estilosTextos.blancoBold),
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
