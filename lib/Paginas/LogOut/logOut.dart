import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:agenda_prueba/Provider/authController.dart';
import 'package:provider/provider.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context);
    final estilosTextos = EstilosTexto();
    final colores = Colores();
    return Scaffold(
      backgroundColor: colores.blanco,
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              Spacer(),
              FloatingActionButton.extended(
                onPressed: () {
                  authProvider.signOut();
                },
                label: Text('Cerrar Sesión'),
                backgroundColor: colores.negro,
                foregroundColor: colores.blanco,
              ),
              SizedBox(width: 30),
            ],
          ),
          Spacer(),
          Text(
            "Lamentablemente no estas autorizado a utilizar esta aplicacion.",
            style: estilosTextos.negro35BoldItalic,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
