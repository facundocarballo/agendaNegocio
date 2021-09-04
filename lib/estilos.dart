import 'package:flutter/material.dart';

class Colores {
  final _blanco = Color.fromRGBO(237, 237, 237, 1);
  final _negro = Color.fromRGBO(17, 17, 17, 1);
  final _verde = Color.fromRGBO(97, 182, 21, 1);
  final _rojo = Color.fromRGBO(218, 0, 55, 1);
  final _azul = Color.fromRGBO(0, 122, 255, 1);

  // Getters...
  Color get blanco => _blanco;
  Color get negro => _negro;
  Color get verde => _verde;
  Color get rojo => _rojo;
  Color get azul => _azul;
}

class EstilosTexto {
  final _blanco40Bold = TextStyle(
    color: Colores().blanco,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );
  final _blanco20Bold = TextStyle(
    color: Colores().blanco,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final _blanco15 = TextStyle(
    color: Colores().blanco,
    fontSize: 15,
  );
  final _blanco30 = TextStyle(
    color: Colores().blanco,
    fontSize: 30,
  );
  final _blanco30Bold = TextStyle(
    color: Colores().blanco,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  final _blanco15Bold = TextStyle(
    color: Colores().blanco,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  final _blancoBold = TextStyle(
    color: Colores().blanco,
    fontWeight: FontWeight.bold,
  );
  final _negro35BoldItalic = TextStyle(
    color: Colores().negro,
    fontSize: 35,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  final _negro35Bold = TextStyle(
    color: Colores().negro,
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );
  final _negro20Bold = TextStyle(
    color: Colores().negro,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final _negro15 = TextStyle(
    color: Colores().negro,
    fontSize: 15,
  );
  final _rojo15Bold = TextStyle(
    color: Colores().rojo,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  final _blanco10 = TextStyle(
    color: Colores().blanco,
    fontSize: 10,
  );

  // Getters...
  TextStyle get blanco40Bold => _blanco40Bold;
  TextStyle get blanco20Bold => _blanco20Bold;
  TextStyle get blanco15 => _blanco15;
  TextStyle get negro20Bold => _negro20Bold;
  TextStyle get negro15 => _negro15;
  TextStyle get blanco30Bold => _blanco30Bold;
  TextStyle get blanco15Bold => _blanco15Bold;
  TextStyle get negro35BoldItalic => _negro35BoldItalic;
  TextStyle get negro35Bold => _negro35Bold;
  TextStyle get blanco30 => _blanco30;
  TextStyle get blancoBold => _blancoBold;
  TextStyle get rojo15Bold => _rojo15Bold;
  TextStyle get blanco10 => _blanco10;
}

class EstilosBotones {
  final _negro = ElevatedButton.styleFrom(primary: Colores().negro);
  final _blanco = ElevatedButton.styleFrom(primary: Colores().blanco);
  final _verdeRadius = ElevatedButton.styleFrom(
      primary: Colores().verde,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ));
  final _rojoRadius = ElevatedButton.styleFrom(
      primary: Colores().rojo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ));
  final _rojo = ElevatedButton.styleFrom(primary: Colores().rojo);
  final _azul = ElevatedButton.styleFrom(primary: Colores().azul);
  final _negroCirculo = ElevatedButton.styleFrom(
    primary: Colores().negro,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(100),
      ),
    ),
  );

  // Getters...

  ButtonStyle get blanco => _blanco;
  ButtonStyle get negro => _negro;
  ButtonStyle get verdeRadius => _verdeRadius;
  ButtonStyle get rojoRadius => _rojoRadius;
  ButtonStyle get rojo => _rojo;
  ButtonStyle get azul => _azul;
  ButtonStyle get negroCirculo => _negroCirculo;
}
