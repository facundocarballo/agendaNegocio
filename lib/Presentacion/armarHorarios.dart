import 'package:agenda_prueba/Presentacion/armarProductos.dart';
import 'package:flutter/material.dart';
import 'package:agenda_prueba/Componentes/Cards/cardDisponibilidadHoraria.dart';
import 'package:agenda_prueba/Provider/configuracionController.dart';
import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:provider/provider.dart';

class ArmarHorarios extends StatefulWidget {
  ArmarHorarios({Key key}) : super(key: key);

  @override
  _ArmarHorariosState createState() => _ArmarHorariosState();
}

class _ArmarHorariosState extends State<ArmarHorarios> {
  String nombreNegocio;
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
                                Container(
                                  height: 40,
                                  width: width - 250,
                                  child: TextFormField(
                                    controller: nombreNegocioController,
                                    textAlignVertical: TextAlignVertical.center,
                                    autofocus: true,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Ingresa el nombre de tu negocio'),
                                    validator: (newName) => newName.isEmpty
                                        ? 'Debes agregar un nombre para tu negocio'
                                        : null,
                                    onFieldSubmitted: (value) async {
                                      print("Value: $value");
                                      // await configuracionController
                                      //     .cambiarNombre(
                                      //   nuevoNombre: value,
                                      //   negocio: negocioProvider.negocio,
                                      // );
                                      // negocioProvider.cambiarNombre(
                                      //   nuevoNombre: value,
                                      // );
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        nombreNegocio = value;
                                      });
                                    },
                                  ),
                                ),
                                Spacer(),
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: MediaQuery.of(context).size.width - 40,
                  height:
                      (nombreNegocio != null && nombreNegocio != '') ? 50 : 0,
                  child: ElevatedButton(
                    child: Text(
                      "Continuar",
                      style: EstilosTexto().blanco20Bold,
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArmarProductos(
                            nombreNegocio: nombreNegocio,
                          ),
                        ),
                      );
                    },
                    style: EstilosBotones().negro,
                  ),
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
