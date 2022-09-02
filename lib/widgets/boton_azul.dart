import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function? function;

  const BotonAzul({Key? key, required this.text, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: const StadiumBorder(),
        backgroundColor: Colors.blue,
      ),
      onPressed: () => function,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
