import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String text_cuenta;
  final String text_ingresar;

  const Labels({super.key, required this.ruta, required this.text_cuenta, required this.text_ingresar});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(text_cuenta,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          
          const SizedBox(
            height: 10,
          ),

          GestureDetector(
            child: Text(
              text_ingresar,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
        ],
      ),
    );
  }
}
