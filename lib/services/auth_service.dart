import 'dart:convert';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class AuthService with ChangeNotifier {
  late final Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => _autenticando;

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};
    var url = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(url, body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
    }

    print('Response status: ${resp.statusCode}');
  }
}
