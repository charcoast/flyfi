import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flyfi/notifiers/ap_selection_controller.dart';
import 'package:flyfi/notifiers/ap_table_controller.dart';

import 'package:flyfi/utilities/ap_find.dart';

import 'package:flyfi/widgets/aptable_widget.dart';
import 'package:flyfi/widgets/formlogin_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool btnProcurar = true;
  final _tUser = TextEditingController();
  final _tPassword = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('AP Selecionado '),
                              AnimatedBuilder(
                                  animation: ApSelectionController.instance,
                                  builder: (context, child) {
                                    return Text(ApSelectionController
                                        .instance.selectedIP);
                                  })
                            ]),
                      ),
                      FormLogin(
                        tUser: _tUser,
                        tPassword: _tPassword,
                        scaffoldKey: _scaffoldKey,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (btnProcurar) {
                    findAP();
                    btnProcurar = false;
                    Timer(Duration(seconds: 4), () {
                      btnProcurar = true;
                    });
                  }
                },
                child: Text('Procurar AP'),
              ),
              AnimatedBuilder(
                  animation: ApTableController.instance,
                  builder: (context, child) {
                    bool searching = ApTableController.instance.searching;
                    return Text(searching
                        ? 'Procurando...'
                        : 'Dispsitivos encontrados');
                  }),
              AnimatedBuilder(
                  animation: ApTableController.instance,
                  builder: (context, child) {
                    List<Map> list = ApTableController.instance.list();

                    return ApTable(apList: list);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
