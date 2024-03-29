import 'package:flutter/material.dart';
import 'package:flyfi/routes/dashboard_page.dart';
import 'package:flyfi/routes/home_page.dart';
import 'package:flyfi/routes/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(title: 'FlyFi'),
        DashboardPage.routeName: (context) => DashboardPage()
      },
    );
  }
}
