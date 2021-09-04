import 'package:agenda_prueba/Provider/turnosController.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Paginas/AgregarTurno/agregar.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:provider/provider.dart';

class CardAgregar extends StatefulWidget {
  final String horario;
  final String dia;
  final String fechaFirebase;
  CardAgregar({this.horario, this.dia, this.fechaFirebase});

  @override
  _CardAgregarState createState() => _CardAgregarState();
}

class _CardAgregarState extends State<CardAgregar> {
  @override
  Widget build(BuildContext context) {
    final turnosProvider = Provider.of<TurnosController>(context);
    final estilosTextos = EstilosTexto();
    final estilosBotones = EstilosBotones();
    return Container(
        width: 150,
        height: 100,
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
              SizedBox(height: 20),
              Text(
                this.widget.horario,
                style: estilosTextos.blanco30Bold,
              ),
              Spacer(),
              Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ElevatedButton(
                  style: estilosBotones.verdeRadius,
                  onPressed: () {
                    turnosProvider.cargarHorario(horario: widget.horario);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Agregar(),
                      ),
                    );
                  },
                  child: Text(
                    'AGREGAR TURNO',
                    style: estilosTextos.blanco15Bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
