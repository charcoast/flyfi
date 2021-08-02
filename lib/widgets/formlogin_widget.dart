import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyfi/notifiers/ap_selection_controller.dart';
import 'package:flyfi/routes/dashboard_page.dart';
import 'package:flyfi/utilities/api/zeus.dart';
import 'package:http/http.dart' as http;

class FormLogin extends StatefulWidget {
  const FormLogin({
    Key? key,
    required TextEditingController tUser,
    required TextEditingController tPassword,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _tUser = tUser,
        _tPassword = tPassword,
        super(key: key);

  final TextEditingController _tUser;
  final TextEditingController _tPassword;
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    return Form(
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
              ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(
                duration: new Duration(seconds: 999),
                content: new Row(
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Text("  Tentando autenticar...")
                  ],
                ),
              ));

              var zeus = Zeus();
              zeus.deviceIp = ApSelectionController.instance.selectedIP;
              zeus.deviceUsername = widget._tUser.text;
              zeus.devicePassword = widget._tPassword.text;
              var loginToken = zeus.login();

              loginToken.then((value) {
                if (value.token != '') {
                  Navigator.of(context).pushReplacementNamed(
                      DashboardPage.routeName,
                      arguments: DashboardArguments(zeus.deviceIp,
                          zeus.deviceUsername, zeus.devicePassword));
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text("Falha ao realizar login"),
                            content: Text(
                                "Confira o dispositivo e os dados de login e senha"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                }
                ScaffoldMessenger.maybeOf(context)!.hideCurrentSnackBar();
              });
            },
            child: Text("Entrar")),
      ]),
    );
  }
}
