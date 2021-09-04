import 'package:flutter/material.dart';

class DisponibilidadHoraria {
  TimeOfDay abreM;
  TimeOfDay abreT;
  TimeOfDay cierraM;
  TimeOfDay cierraT;
  int duracion;
  bool disponible;
  bool trabajoDeCorrido;

  DisponibilidadHoraria({
    @required this.abreM,
    @required this.cierraM,
    @required this.abreT,
    @required this.cierraT,
    @required this.duracion,
    @required this.disponible,
    @required this.trabajoDeCorrido,
  });
}
