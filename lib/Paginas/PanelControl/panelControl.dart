import 'package:flutter/material.dart';
import 'package:agenda_prueba/Componentes/Header/header.dart';
import 'package:agenda_prueba/Componentes/Header/mobileHeader.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Paginas/PanelControl/barras.dart';
import 'package:agenda_prueba/Provider/panelControl.dart';
import 'package:provider/provider.dart';

class PanelControl extends StatefulWidget {
  @override
  _PanelControlState createState() => _PanelControlState();
}

class _PanelControlState extends State<PanelControl> {
  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final estilosTextos = EstilosTexto();
    final colores = Colores();
    return Scaffold(
      backgroundColor: colores.blanco,
      body: Container(
        child: Column(
          children: [
            width > 600 ? Header() : MobileHeader(),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  '${panelProvider.turnosXmes} Turnos',
                  style: estilosTextos.negro20Bold,
                ),
                Spacer(),
                // DatePicker
                DropdownButton(
                  value: panelProvider.month,
                  items: panelProvider.meses.map((String items) {
                    return DropdownMenuItem(
                      child: Text(items),
                      value: items,
                    );
                  }).toList(),
                  onChanged: (dynamic mes) =>
                      panelProvider.cambiarMes(mes: mes),
                ),
                SizedBox(width: 40),
              ],
            ),
            SizedBox(height: 60),
            Barras(),
          ],
        ),
      ),
    );
  }
}
