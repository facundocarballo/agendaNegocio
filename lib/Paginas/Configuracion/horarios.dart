import 'package:agenda_prueba/Componentes/Cards/cardDisponibilidadHoraria.dart';
import 'package:agenda_prueba/Componentes/Header/header.dart';
import 'package:agenda_prueba/Componentes/Header/mobileHeader.dart';
import 'package:agenda_prueba/Provider/configuracionController.dart';
import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Antes este archivo se llamaba configuracion.dart
// Pero como voy a implementar la edicion de los productos y la edicion de los horarios por separados.
// me parecio mejor idea llamar a este archivo horarios.dart.

class Configuracion extends StatefulWidget {
  Configuracion({Key key}) : super(key: key);

  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool editar = false;
  TextEditingController nombreNegocioController = TextEditingController();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final dias = [
    'Domingo',
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
  ];

  onFieldSubmitted({@required BuildContext context}) async {
    if (_keyForm.currentState.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    final colores = Colores();
    final width = MediaQuery.of(context).size.width;
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    ConfiguaracionController configuracionController =
        Provider.of<ConfiguaracionController>(context);

    return FutureBuilder(
      future: configuracionController.obtenerDisponibilidadHoraria(
        negocio: negocioProvider.negocio,
      ),
      builder: (context, snapshot) {
        return Container(
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                width > 600 ? Header() : MobileHeader(),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 35),
                              Text('Nombre Negocio'),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: colores.negro),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 15),
                                !editar
                                    ? Text(
                                        negocioProvider.negocio.nombre == null
                                            ? 'Ingresa el nombre de tu negocio'
                                            : negocioProvider.negocio.nombre,
                                        style: EstilosTexto().negro20Bold,
                                      )
                                    : Container(
                                        height: 40,
                                        width: width - 250,
                                        child: TextFormField(
                                          controller: nombreNegocioController,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          autofocus: true,
                                          textAlign: TextAlign.start,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          validator: (newName) => newName
                                                  .isEmpty
                                              ? 'Debes agregar un nombre para tu negocio'
                                              : null,
                                          onFieldSubmitted: (value) async {
                                            print("Value: $value");
                                            await configuracionController
                                                .cambiarNombre(
                                              nuevoNombre: value,
                                              negocio: negocioProvider.negocio,
                                            );
                                            negocioProvider.cambiarNombre(
                                              nuevoNombre: value,
                                            );
                                          },
                                        ),
                                      ),
                                Spacer(),
                                !editar
                                    ? ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            editar = true;
                                          });
                                        },
                                        child: Text('Editar'),
                                      )
                                    : Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              print(
                                                  'value guardar: ${nombreNegocioController.text}');
                                              negocioProvider.cambiarNombre(
                                                nuevoNombre:
                                                    nombreNegocioController
                                                        .text,
                                              );
                                              configuracionController
                                                  .cambiarNombre(
                                                nuevoNombre:
                                                    nombreNegocioController
                                                        .text,
                                                negocio:
                                                    negocioProvider.negocio,
                                              );

                                              setState(() {
                                                editar = false;
                                              });
                                            },
                                            child: Text('Guardar'),
                                          ),
                                          SizedBox(width: 15),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                editar = false;
                                              });
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                        ],
                                      ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      "Horarios de Atención",
                      style: EstilosTexto().negro20Bold,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dias.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 500,
                          height: 400,
                          child: Row(
                            children: [
                              Spacer(),
                              CardDisponibilidadHoraria(
                                index: index,
                                dia: dias[index],
                                disponibilidadHoraria: configuracionController
                                    .disponibilidadHoraria[index],
                              ),
                              Spacer(),
                            ],
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          "Guardar Horarios",
                          style: EstilosTexto().blanco20Bold,
                        ),
                        onPressed: () async {
                          await configuracionController
                              .guardarDisponibilidadHoraria(
                            negocio: negocioProvider.negocio,
                          );
                          negocioProvider.cambiarHorarios(
                            nuevosHorarios:
                                configuracionController.disponibilidadHoraria,
                          );
                        },
                        style: EstilosBotones().negro,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
