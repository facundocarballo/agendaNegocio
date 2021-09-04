import 'package:agenda_prueba/Clases/clientes.dart';
import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgregarCliente extends StatefulWidget {
  AgregarCliente({Key key}) : super(key: key);

  @override
  _AgregarClienteState createState() => _AgregarClienteState();
}

class _AgregarClienteState extends State<AgregarCliente> {
  @override
  Widget build(BuildContext context) {
    final colores = Colores();
    final botones = EstilosBotones();
    final clientesController = Provider.of<ClientesController>(context);
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController apellidoController = TextEditingController();
    final TextEditingController aliasController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController telefonoController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    onFieldSubmitted({
      @required BuildContext context,
      @required Negocio negocio,
    }) async {
      if (_formKey.currentState.validate()) {
        final cliente = Cliente(
          apellido: apellidoController.text,
          nombre: nombreController.text,
          fotoURL: '',
          email: emailController.text,
          telefono: telefonoController.text,
          alias: aliasController.text,
        );
        await clientesController.crearClienteFirestore(
          cliente: cliente,
          negocio: negocio,
        );
        //await cliente.crearClienteFirestore();
        print('Cliente agregado...');
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Cliente'),
        backgroundColor: colores.negro,
        foregroundColor: colores.blanco,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextFormField(
                      controller: nombreController,
                      decoration: InputDecoration(hintText: '* Nombre'),
                      validator: (nombre) {
                        return nombre.isEmpty
                            ? 'El nombre del cliente es requerido'
                            : null;
                      },
                      onFieldSubmitted: (value) => onFieldSubmitted(
                        context: context,
                        negocio: negocioProvider.negocio,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 70,
                    child: TextFormField(
                      controller: apellidoController,
                      decoration: InputDecoration(hintText: '* Apellido'),
                      validator: (apellido) {
                        return apellido.isEmpty
                            ? 'El apellido del cliente es requerido'
                            : null;
                      },
                      onFieldSubmitted: (value) => onFieldSubmitted(
                        context: context,
                        negocio: negocioProvider.negocio,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 70,
                    child: TextFormField(
                      controller: aliasController,
                      decoration: InputDecoration(hintText: 'Alias'),
                      onFieldSubmitted: (value) => onFieldSubmitted(
                        context: context,
                        negocio: negocioProvider.negocio,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 70,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                      onFieldSubmitted: (value) => onFieldSubmitted(
                        context: context,
                        negocio: negocioProvider.negocio,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 70,
                    child: TextFormField(
                      controller: telefonoController,
                      decoration: InputDecoration(hintText: 'Telefono'),
                      onFieldSubmitted: (value) => onFieldSubmitted(
                        context: context,
                        negocio: negocioProvider.negocio,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    child: ElevatedButton(
                      child: Text('Agregar Cliente'),
                      onPressed: () => onFieldSubmitted(
                        context: context,
                        negocio: negocioProvider.negocio,
                      ),
                      style: botones.azul,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
