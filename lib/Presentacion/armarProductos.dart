import 'package:agenda_prueba/Provider/negocio.dart';
import 'package:agenda_prueba/funciones.dart';
import 'package:agenda_prueba/Clases/negocio.dart';
import 'package:agenda_prueba/Provider/configuracionController.dart';
import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArmarProductos extends StatefulWidget {
  final String nombreNegocio;
  ArmarProductos({
    Key key,
    this.nombreNegocio,
  }) : super(key: key);

  @override
  _ArmarProductosState createState() => _ArmarProductosState();
}

class _ArmarProductosState extends State<ArmarProductos> {
  String nombreProducto;
  String precioProducto;
  List<Producto> productos = [];
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController nombreProductoController = TextEditingController();
  TextEditingController precioProductoController = TextEditingController();
  // Funciones
  guardarProducto() {
    if (_keyForm.currentState.validate()) {
      print('Guardar Producto');
      final producto = Producto(
        nombre: nombreProductoController.text,
        precio: precioProductoController.text,
      );
      productos.add(producto);
      setState(() {
        nombreProductoController.text = '';
        precioProductoController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ConfiguaracionController configuracionController =
        Provider.of<ConfiguaracionController>(context);
    NegocioProvider negocioProvider = Provider.of<NegocioProvider>(context);
    final width = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      appBar: AppBar(
        title: Text('Armar Productos'),
        centerTitle: true,
        backgroundColor: Colores().negro,
        foregroundColor: Colores().blanco,
      ),
      body: Form(
        key: _keyForm,
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Spacer(),
                Container(
                  width: width,
                  height: MediaQuery.of(context).size.height / 2.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colores().negro.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            width: width - 20,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colores().blanco,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: nombreProductoController,
                                textAlignVertical: TextAlignVertical.center,
                                autofocus: true,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nombre del producto',
                                ),
                                validator: (newName) => newName.isEmpty
                                    ? 'Debes agregar un nombre para tu producto'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    nombreProducto = value;
                                  });
                                },
                                onFieldSubmitted: (_) => guardarProducto(),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: width - 20,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colores().blanco,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: precioProductoController,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Precio del producto',
                            ),
                            validator: (newName) =>
                                int.tryParse(newName) == null
                                    ? 'Debes agregar un numero valido'
                                    : null,
                            onChanged: (value) {
                              setState(() {
                                precioProducto = value;
                              });
                            },
                            onFieldSubmitted: (_) => guardarProducto(),
                          ),
                        ),
                      ),
                      Spacer(),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: width - 20,
                        height:
                            ((nombreProducto != null && nombreProducto != '') &&
                                    (precioProducto != null &&
                                        precioProducto != ''))
                                ? 70
                                : 0,
                        child: ElevatedButton(
                          onPressed: () => guardarProducto(),
                          child: Text('Guardar Producto'),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Container(
              width: width,
              height: MediaQuery.of(context).size.height / 3,
              child: productos.isNotEmpty
                  ? GridView.count(
                      crossAxisCount:
                          cantidadCards(width: 250, context: context),
                      padding: EdgeInsets.all(20),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 250 / 50,
                      children: productos
                          .map((elProducto) => Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colores().negro,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      elProducto.nombre,
                                      style: EstilosTexto().blanco15Bold,
                                    ),
                                    Spacer(),
                                    Text(
                                      '\$${elProducto.precio}',
                                      style: EstilosTexto().blanco15Bold,
                                    ),
                                    SizedBox(width: 10)
                                  ],
                                ),
                              ))
                          .toList(),
                    )
                  : SizedBox(height: 0),
            ),
            Spacer(),
            Container(
              width: width,
              height: 70,
              child: ElevatedButton(
                onPressed: () async {
                  await negocioProvider.terminarPrimeraConfiguracion(
                    nuevoNombre: widget.nombreNegocio,
                    productos: productos,
                  );
                  await configuracionController.guardarDisponibilidadHoraria(
                    negocio: negocioProvider.negocio,
                  );
                  await configuracionController.guardarDisponibilidadHoraria(
                    negocio: negocioProvider.negocio,
                  );
                  negocioProvider.notificador();
                  Navigator.pop(context);
                },
                style: EstilosBotones().negro,
                child: Text('Guardar Mi Negocio'),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
