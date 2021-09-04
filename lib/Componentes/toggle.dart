import 'package:agenda_prueba/estilos.dart';
import 'package:flutter/material.dart';

class TheToggle extends StatefulWidget {
  final bool isSelected;
  TheToggle({@required this.isSelected});
  @override
  _TheToggleState createState() => _TheToggleState();
}

class _TheToggleState extends State<TheToggle> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? isSelected = false : isSelected = true;
        });
      },
      child: Container(
        width: 45,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              isSelected ? Colores().verde : Colores().negro.withOpacity(0.3),
        ),
        child: Row(
          children: [
            !isSelected
                ? GestureDetector(
                    onTap: () {
                      print('pp');
                      setState(() {
                        isSelected = true;
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colores().blanco,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                : SizedBox(width: 0),
            Spacer(),
            isSelected
                ? GestureDetector(
                    onTap: () {
                      print('object');
                      setState(() {
                        isSelected = false;
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colores().blanco,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                : SizedBox(width: 0),
          ],
        ),
      ),
    );
  }
}
