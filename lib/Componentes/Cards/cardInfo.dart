import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'cardCliente.dart';

class CardInfo extends StatefulWidget {
  final String titulo;
  final bool visitas;
  CardInfo({@required this.titulo, @required this.visitas});
  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  @override
  Widget build(BuildContext context) {
    final titulo = widget.titulo;
    final visitas = widget.visitas;
    final width = (MediaQuery.of(context).size.width / 2) - 40;
    final height = MediaQuery.of(context).size.height;
    final colores = Colores();
    final estilosTexto = EstilosTexto();
    return Container(
      width: width,
      height: (height / 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colores.negro,
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                titulo,
                style: estilosTexto.blanco20Bold,
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: width - 20,
            height: 2,
            color: colores.blanco,
          ),
          SizedBox(height: 10),
          CardCliente(
              nombre: 'Facundo Carballo', visitas: visitas, width: width)
        ],
        // Agregar los clientes....
      ),
    );
  }
}
