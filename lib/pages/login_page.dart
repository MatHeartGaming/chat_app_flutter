// ignore_for_file: prefer_const_constructors

import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/label.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Logo(
                  titulo: "MatBuompy's Messenger",
                ),
                _Form(),
                Labels(
                  ruta: 'register',
                  text_cuenta: 'No tienes cuenta?',
                  text_ingresar: "Crea una ahora!",
                ),
                Text(
                  "Terminos y condiciones de uso",
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      width: MediaQuery.of(context).size.width / 1.1,
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
              text: "Ingresar",
              function: authService.autenticando
                  ? null
                  : () {
                      print("Correo: ${emailCtrl.text}");
                      print("Correo: ${passCtrl.text}");
                      FocusScope.of(context).unfocus();
                      authService.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());
                    }),
        ],
      ),
    );
  }
}
