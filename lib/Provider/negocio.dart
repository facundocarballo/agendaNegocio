import 'package:agenda_prueba/Clases/disponibilidadHoraria.dart';
import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NegocioProvider extends ChangeNotifier {
  Negocio _negocio = Negocio();
  bool auxSeleccionProducto = false;
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  // Getters
  Negocio get negocio => _negocio;

  // Funciones

  signIn() async {
    print('SignIn...');
    final googleUser = await _googleSignIn.signIn();
    print('1');
    final googleAuth = await googleUser.authentication;
    print('Credential');
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    print('2');
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    negocio.email = user.email;
    negocio.nombreDueno = user.displayName;
    negocio.telefono = user.phoneNumber;
    negocio.fotoURL = user.photoURL;
    notifyListeners();
  }

  cambiarNombre({@required String nuevoNombre}) {
    _negocio.nombre = nuevoNombre;
    notifyListeners();
  }

  agregarProducto({@required Producto nuevoProducto}) {
    _negocio.productos.add(nuevoProducto);
    notifyListeners();
  }

  terminarPrimeraConfiguracion({
    @required String nuevoNombre,
    @required List<Producto> productos,
  }) async {
    print('productos: ${productos.length}');
    _negocio.nombre = nuevoNombre;
    _negocio.productos = productos;
    final doc = FirebaseFirestore.instance.collection('Negocio').doc();
    _negocio.id = doc.id;
    await doc.set({
      'nombre': _negocio.nombre,
      'email': _negocio.email,
      'fotoURL': _negocio.fotoURL,
      'productos': armarProductos(),
    });
  }

  List<Map<String, String>> armarProductos() {
    List<Map<String, String>> mapaProductos = [];
    _negocio.productos.forEach(
      (elProducto) => mapaProductos.add(
        {
          'precio': elProducto.precio,
          'nombre': elProducto.nombre,
        },
      ),
    );
    return mapaProductos;
  }

  notificador() {
    notifyListeners();
  }

  String disponibilidadHorariaToString({@required TimeOfDay time}) {
    final hora = '${time.hour}';
    final minutos = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    return '$hora:$minutos';
  }

  cambiarHorarios({@required List<DisponibilidadHoraria> nuevosHorarios}) {
    for (var i = 0; i < nuevosHorarios.length; i++) {
      print('i: $i');
      print(disponibilidadHorariaToString(time: nuevosHorarios[i].abreM));
      switch (i) {
        case 0:
          _negocio.domingo.inicioManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreM);
          _negocio.domingo.inicioTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreT);
          _negocio.domingo.finManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraM);
          _negocio.domingo.finTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraT);
          break;
        case 1:
          _negocio.lunes.inicioManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreM);
          _negocio.lunes.inicioTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreT);
          _negocio.lunes.finManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraM);
          _negocio.lunes.finTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraT);
          break;
        case 2:
          _negocio.martes.inicioManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreM);
          _negocio.martes.inicioTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreT);
          _negocio.martes.finManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraM);
          _negocio.martes.finTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraT);
          break;
        case 3:
          _negocio.miercoles.inicioManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreM);
          _negocio.miercoles.inicioTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreT);
          _negocio.miercoles.finManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraM);
          _negocio.miercoles.finTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraT);
          break;
        case 4:
          _negocio.jueves.inicioManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreM);
          _negocio.jueves.inicioTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreT);
          _negocio.jueves.finManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraM);
          _negocio.jueves.finTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraT);
          break;
        case 5:
          _negocio.viernes.inicioManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreM);
          _negocio.viernes.inicioTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreT);
          _negocio.viernes.finManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraM);
          _negocio.viernes.finTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraT);
          break;
        case 6:
          _negocio.sabado.inicioManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreM);
          _negocio.sabado.inicioTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].abreT);
          _negocio.sabado.finManana =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraM);
          _negocio.sabado.finTarde =
              disponibilidadHorariaToString(time: nuevosHorarios[i].cierraT);
          break;
        default:
      }
    }
  }

  Future<Negocio> getNegocio() async {
    var user = _auth.currentUser;
    if (user == null) {
      user = await _auth.authStateChanges().first;
    }
    _negocio.email = user.email;
    _negocio.nombreDueno = user.displayName;
    _negocio.telefono = user.phoneNumber;
    _negocio.fotoURL = user.photoURL;
    await _negocio.obtenerElNegocio(email: user.email);
    return _negocio;
  }
}
