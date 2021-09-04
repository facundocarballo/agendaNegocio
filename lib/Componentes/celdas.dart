import 'package:flutter/material.dart';

class Celdas extends StatefulWidget {
  final bool isCliente;
  final Widget child;

  Celdas({Key key, @required this.isCliente, @required this.child})
      : super(key: key);

  @override
  _CeldasState createState() => _CeldasState();
}

class _CeldasState extends State<Celdas> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2;
    // Este width solo funciona para Desktop.
    return Container(
      height: 70,
      width: widget.isCliente ? width : width / 4.5,
      child: widget.child,
    );
  }
}
