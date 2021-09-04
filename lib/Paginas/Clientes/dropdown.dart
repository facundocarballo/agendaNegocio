import 'package:agenda_prueba/Paginas/Clientes/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  DropDown({Key key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    final clientesController = Provider.of<ClientesController>(context);
    return DropdownButton(
      items: clientesController.dropDownList.map((item) {
        return DropdownMenuItem(
          child: Text(item),
          value: item,
        );
      }).toList(),
      onChanged: (dynamic item) {
        clientesController.cambiarDropDown(item: item);
      },
      value: clientesController.dropDown,
    );
  }
}
