import 'package:agenda_prueba/Desktop/app.dart';
import 'package:agenda_prueba/Mobile/mobileApp.dart';
import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:agenda_prueba/Paginas/Login/login.dart';
import 'package:agenda_prueba/Presentacion/presentacion.dart';
import 'package:agenda_prueba/Provider/configuracionController.dart';
import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:agenda_prueba/Provider/turnosController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/fecha.dart';
import 'Provider/authController.dart';
import 'Provider/paginas.dart';
import 'Provider/panelControl.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FechaProvider()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => PanelProvider()),
        ChangeNotifierProvider(create: (_) => PaginasProvider()),
        ChangeNotifierProvider(create: (_) => ClientesController()),
        ChangeNotifierProvider(create: (_) => NegocioProvider()),
        ChangeNotifierProvider(create: (_) => TurnosController()),
        ChangeNotifierProvider(create: (_) => ConfiguaracionController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Negocio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final negocioProvider = Provider.of<NegocioProvider>(context);
    return FutureBuilder(
      future: negocioProvider.getNegocio(),
      builder: (context, snapshoot) {
        if (snapshoot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshoot.hasData) {
          return Center(
            child: Login(),
          );
        }
        if (snapshoot.data.nombre == null) {
          return Presentacion();
        }
        if (MediaQuery.of(context).size.width > 600) {
          return App();
        } else {
          return MobileApp();
        }
      },
    );
  }
}
