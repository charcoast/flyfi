import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static const routeName = '/dashboard';
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DashboardArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text(
                  'Dashboard Logado',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardArguments {
  final String ip;
  final String username;
  final String password;

  DashboardArguments(this.ip, this.username, this.password);
}
