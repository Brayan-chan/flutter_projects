import 'package:flutter/material.dart';

//Estructura de la pagina
class ContainerOne extends StatelessWidget {
  const ContainerOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Crear el cuerpo de tipo contenedor
      body: Center(
        child: Container(
          //Configuracion del contenedor

          //altura del contenedor
          height: 200,

          //anchura del contenedor
          width: 200,

          //Agregar la decoracion al contenedor
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(15),

            //Color del contenedor
            color: Colors.red,

            //Convertir el contenedor a un circulo
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
