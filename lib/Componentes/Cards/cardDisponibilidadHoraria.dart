import 'package:agenda_prueba/Clases/disponibilidadHoraria.dart';
import 'package:agenda_prueba/Componentes/divider.dart';
import 'package:agenda_prueba/Provider/configuracionController.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDisponibilidadHoraria extends StatefulWidget {
  final int index;
  final String dia;
  final DisponibilidadHoraria disponibilidadHoraria;
  CardDisponibilidadHoraria({
    Key key,
    this.index,
    this.dia,
    this.disponibilidadHoraria,
  }) : super(key: key);

  @override
  _CardDisponibilidadHorariaState createState() =>
      _CardDisponibilidadHorariaState();
}

class _CardDisponibilidadHorariaState extends State<CardDisponibilidadHoraria> {
  TimeOfDay abreM = TimeOfDay.now();
  TimeOfDay abreT = TimeOfDay.now();
  TimeOfDay cierraM = TimeOfDay.now();
  TimeOfDay cierraT = TimeOfDay.now();
  bool disponible = false;
  bool trabajoDeCorrido = false;
  List<String> listaDuracion = [
    '15 minutos',
    '30 minutos',
    '60 minutos',
    '120 minutos',
  ];
  String duracion = '15 minutos';
  @override
  Widget build(BuildContext context) {
    abreM = widget.disponibilidadHoraria.abreM;
    abreT = widget.disponibilidadHoraria.abreT;
    cierraM = widget.disponibilidadHoraria.cierraM;
    cierraT = widget.disponibilidadHoraria.cierraT;
    disponible = widget.disponibilidadHoraria.disponible;
    trabajoDeCorrido = widget.disponibilidadHoraria.trabajoDeCorrido;
    // Hacer todo lo del configuracionController en negocioProvider.
    final configuracionController =
        Provider.of<ConfiguaracionController>(context);
    // No lo podemos hacer animado porque da un RenderFlex Overflowed.
    return disponible
        ? AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: 450,
            height: 400,
            decoration: BoxDecoration(
              color: Colores().negro.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(children: [
                  SizedBox(width: 15),
                  Text(
                    widget.dia != null ? widget.dia : 'NULL',
                    style: EstilosTexto().negro20Bold,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: disponible ? Colores().negro : Colores().blanco,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        configuracionController.cambiarDisponibilidad(
                          index: widget.index,
                        );
                      },
                      icon: disponible
                          ? Icon(
                              Icons.done,
                              color: Colores().blanco,
                            )
                          : Icon(
                              Icons.clear,
                              color: Colores().negro,
                            ),
                    ),
                  ),
                  SizedBox(width: 15),
                ]),
                SizedBox(height: 10),
                TheDivider(
                  width: 400,
                  height: 2,
                  color: Colores().negro.withOpacity(0.2),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text('Trabajo de corrido'),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: trabajoDeCorrido
                            ? Colores().negro
                            : Colores().blanco,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          configuracionController.cambiarTrabajoDeCorrido(
                            index: widget.index,
                          );
                        },
                        icon: trabajoDeCorrido
                            ? Icon(
                                Icons.done,
                                color: Colores().blanco,
                              )
                            : Icon(
                                Icons.clear,
                                color: Colores().negro,
                              ),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 10),
                TheDivider(
                  width: 400,
                  height: 2,
                  color: Colores().negro.withOpacity(0.2),
                ),
                SizedBox(height: 10),
                // Manana y Tarde
                trabajoDeCorrido
                    ? AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            SizedBox(height: 70),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Container(
                                  width: 150,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: EstilosBotones().blanco,
                                    onPressed: () async {
                                      final newTime = await showTimePicker(
                                          context: context, initialTime: abreM);
                                      newTime != null
                                          ? configuracionController
                                              .cambiarAbreM(
                                                  newTime: newTime,
                                                  index: widget.index)
                                          : null;
                                    },
                                    child: Text(
                                      abreM == TimeOfDay.now()
                                          ? 'Abre'
                                          : 'Abre: ${abreM.hour}:${abreM.minute < 10 ? '0${abreM.minute}' : '${abreM.minute}'}',
                                      style: EstilosTexto().negro20Bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 150,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: EstilosBotones().blanco,
                                    onPressed: () async {
                                      final newTime = await showTimePicker(
                                        context: context,
                                        initialTime: cierraM,
                                      );
                                      newTime != null
                                          ? configuracionController
                                              .cambiarCierraM(
                                                  newTime: newTime,
                                                  index: widget.index)
                                          : null;
                                    },
                                    child: Text(
                                      cierraM == TimeOfDay.now()
                                          ? 'Cierra'
                                          : 'Cierra: ${cierraM.hour}:${cierraM.minute < 10 ? '0${cierraM.minute}' : '${cierraM.minute}'}',
                                      style: EstilosTexto().negro20Bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ],
                        ),
                      )
                    : AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Text(
                                  'Mañana',
                                  style: EstilosTexto().negro20Bold,
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Container(
                                  width: 150,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: EstilosBotones().blanco,
                                    onPressed: () async {
                                      final newTime = await showTimePicker(
                                          context: context, initialTime: abreM);
                                      newTime != null
                                          ? configuracionController
                                              .cambiarAbreM(
                                                  newTime: newTime,
                                                  index: widget.index)
                                          : null;
                                    },
                                    child: Text(
                                      abreM == TimeOfDay.now()
                                          ? 'Abre'
                                          : 'Abre: ${abreM.hour}:${abreM.minute < 10 ? '0${abreM.minute}' : '${abreM.minute}'}',
                                      style: EstilosTexto().negro20Bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 150,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: EstilosBotones().blanco,
                                    onPressed: () async {
                                      final newTime = await showTimePicker(
                                        context: context,
                                        initialTime: cierraM,
                                      );
                                      newTime != null
                                          ? configuracionController
                                              .cambiarCierraM(
                                                  newTime: newTime,
                                                  index: widget.index)
                                          : null;
                                    },
                                    child: Text(
                                      cierraM == TimeOfDay.now()
                                          ? 'Cierra'
                                          : 'Cierra: ${cierraM.hour}:${cierraM.minute < 10 ? '0${cierraM.minute}' : '${cierraM.minute}'}',
                                      style: EstilosTexto().negro20Bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Text(
                                  'Tarde',
                                  style: EstilosTexto().negro20Bold,
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Container(
                                  width: 150,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: EstilosBotones().blanco,
                                    onPressed: () async {
                                      final newTime = await showTimePicker(
                                        context: context,
                                        initialTime: abreT,
                                      );
                                      newTime != null
                                          ? configuracionController
                                              .cambiarAbreT(
                                                  newTime: newTime,
                                                  index: widget.index)
                                          : null;
                                    },
                                    child: Text(
                                      abreT == TimeOfDay.now()
                                          ? 'Abre'
                                          : 'Abre: ${abreT.hour}:${abreT.minute < 10 ? '0${abreT.minute}' : '${abreT.minute}'}',
                                      style: EstilosTexto().negro20Bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 150,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: EstilosBotones().blanco,
                                    onPressed: () async {
                                      final newTime = await showTimePicker(
                                        context: context,
                                        initialTime: cierraT,
                                      );
                                      if (newTime != null) {
                                        configuracionController.cambiarCierraT(
                                          newTime: newTime,
                                          index: widget.index,
                                        );
                                      }
                                    },
                                    child: Text(
                                      cierraT == TimeOfDay.now()
                                          ? 'Cierra'
                                          : 'Cierra: ${cierraT.hour}:${cierraT.minute < 10 ? '0${cierraT.minute}' : '${cierraT.minute}'}',
                                      style: EstilosTexto().negro20Bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ],
                        ),
                      ),

                Spacer(),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      'Duracion de cada turno:',
                      style: EstilosTexto().negro20Bold,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Container(
                      width: 95,
                      height: 40,
                      child: ElevatedButton(
                        style: configuracionController
                                    .disponibilidadHoraria[widget.index]
                                    .duracion ==
                                15
                            ? EstilosBotones().negro
                            : EstilosBotones().blanco,
                        onPressed: () {
                          configuracionController.cambiarDuracion(
                            index: widget.index,
                            nuevaDuracion: 15,
                          );
                        },
                        child: Text(
                          '15 minutos',
                          style: configuracionController
                                      .disponibilidadHoraria[widget.index]
                                      .duracion ==
                                  15
                              ? EstilosTexto().blanco15Bold
                              : EstilosTexto().negro15,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 95,
                      height: 40,
                      child: ElevatedButton(
                        style: configuracionController
                                    .disponibilidadHoraria[widget.index]
                                    .duracion ==
                                30
                            ? EstilosBotones().negro
                            : EstilosBotones().blanco,
                        onPressed: () {
                          configuracionController.cambiarDuracion(
                            index: widget.index,
                            nuevaDuracion: 30,
                          );
                        },
                        child: Text(
                          '30 minutos',
                          style: configuracionController
                                      .disponibilidadHoraria[widget.index]
                                      .duracion ==
                                  30
                              ? EstilosTexto().blanco15Bold
                              : EstilosTexto().negro15,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 95,
                      height: 40,
                      child: ElevatedButton(
                        style: configuracionController
                                    .disponibilidadHoraria[widget.index]
                                    .duracion ==
                                60
                            ? EstilosBotones().negro
                            : EstilosBotones().blanco,
                        onPressed: () {
                          configuracionController.cambiarDuracion(
                            index: widget.index,
                            nuevaDuracion: 60,
                          );
                        },
                        child: Text(
                          '1 hora',
                          style: configuracionController
                                      .disponibilidadHoraria[widget.index]
                                      .duracion ==
                                  60
                              ? EstilosTexto().blanco15Bold
                              : EstilosTexto().negro15,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 90,
                      height: 40,
                      child: ElevatedButton(
                        style: configuracionController
                                    .disponibilidadHoraria[widget.index]
                                    .duracion ==
                                120
                            ? EstilosBotones().negro
                            : EstilosBotones().blanco,
                        onPressed: () {
                          configuracionController.cambiarDuracion(
                            index: widget.index,
                            nuevaDuracion: 120,
                          );
                        },
                        child: Text(
                          '2 horas',
                          style: configuracionController
                                      .disponibilidadHoraria[widget.index]
                                      .duracion ==
                                  120
                              ? EstilosTexto().blanco15Bold
                              : EstilosTexto().negro15,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          )
        : AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: 450,
            height: 400,
            decoration: BoxDecoration(
              color: Colores().blanco,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colores().negro.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          Text(
                            widget.dia != null ? widget.dia : 'NULL',
                            style: EstilosTexto().negro20Bold,
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: disponible
                                  ? Colores().negro
                                  : Colores().blanco,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () {
                                configuracionController.cambiarDisponibilidad(
                                  index: widget.index,
                                );
                              },
                              icon: disponible
                                  ? Icon(
                                      Icons.done,
                                      color: Colores().blanco,
                                    )
                                  : Icon(
                                      Icons.clear,
                                      color: Colores().negro,
                                    ),
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          );
  }
}
