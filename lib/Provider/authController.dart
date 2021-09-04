import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Clases/negocio.dart';

class AuthController extends ChangeNotifier {
  // Esta clase no se usa.
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _usuario = Usuario();
  bool auxGet = true;

  Usuario get usuario => _usuario;

  signIn() async {
    print('SignIn...');
    final googleUser = await _googleSignIn.signIn();
    print(googleUser.email);
    print('1');
    final googleAuth = await googleUser.authentication;
    print(googleAuth.accessToken);
    print('Credential');
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('2');
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    _usuario.email = user.email;
    _usuario.fotoURL = user.photoURL;
    _usuario.nombre = user.displayName;
    notifyListeners();
  }

  Future<Usuario> getUser() async {
    print('get');
    var user = _auth.currentUser;
    if (user == null) {
      print('not');
      user = await _auth.authStateChanges().first;
      print('Usuario: ${user.email}');
      notifyListeners();
    } else {
      print('pasamos de largo');
    }

    return Usuario(
        email: user.email, nombre: user.displayName, fotoURL: user.photoURL);
  }

  signOut() {
    print("SignOut...");
    _googleSignIn.signOut();
    _auth.signOut();
    notifyListeners();
  }
}
