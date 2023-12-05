import 'package:flutter/material.dart';
import 'package:pdv_project_teste_1/Screens/VendaPage.dart';
import 'package:pdv_project_teste_1/Screens/VendasHojePage.dart';
import 'package:pdv_project_teste_1/Screens/homePage.dart';
import 'package:pdv_project_teste_1/Screens/loginPage.dart';
import 'package:pdv_project_teste_1/routes/routes.dart';
import 'package:pdv_project_teste_1/service/productProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ProductProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDV-teste',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        Routes.LOGIN_PAGE: (context) => LoginPage(),
        Routes.HOME: (context) => HomePage(),
        Routes.VENDA: (context) => VendaPage(),
        Routes.VENDAS_HOJE: (context) => VendasHojePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
