import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final negocioProvider = Provider.of<NegocioProvider>(context);
    final colores = Colores();
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () {
          negocioProvider.signIn();
        },
        label: Text('Iniciar Sesion con Google'),
        icon: Icon(Icons.security),
        backgroundColor: colores.negro,
        foregroundColor: colores.blanco,
      ),
    );
  }
}
