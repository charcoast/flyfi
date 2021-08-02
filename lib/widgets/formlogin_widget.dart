import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyfi/notifiers/ap_selection_controller.dart';
import 'package:http/http.dart' as http;

class FormLogin extends StatefulWidget {
  const FormLogin({
    Key? key,
    required TextEditingController tUser,
    required TextEditingController tPassword,
  })  : _tUser = tUser,
        _tPassword = tPassword,
        super(key: key);

  final TextEditingController _tUser;
  final TextEditingController _tPassword;

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          controller: widget._tUser,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Informe o login";
            }
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Usuário'),
        ),
        SizedBox(
          height: 13.0,
        ),
        TextFormField(
          controller: widget._tPassword,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Informe a senha";
            }
          },
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: 'Senha'),
        ),
        SizedBox(
          height: 13.0,
        ),
        ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              } else {
                final ip = ApSelectionController.instance.selectedIP;
                final username = widget._tUser.text;
                final password = widget._tPassword.text;
                deviceLogin(context, ip, username, password);
              }
            },
            child: Text("Entrar")),
      ]),
    );
  }
}

deviceLogin(BuildContext context, String ip, String username, String password) {
  final response = connectAp(ip, username, password);
  print(response);
}

connectAp(String ip, String username, String password) {
  print('$ip $username $password');
  return http.post(
      Uri.parse('http://192.168.100.1/cgi-bin/api/v3/system/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'data': {'username': username, 'password': password}
      }));
}
