import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pdv_project_teste_1/Widgets/VendaWidget.dart';
import 'package:pdv_project_teste_1/routes/routes.dart';
import 'package:pdv_project_teste_1/service/productProvider.dart';
import 'package:provider/provider.dart';

import '../Models/User.dart';

class VendaPage extends StatelessWidget {
  VendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Acessando os valores do argumento 'user' e 'randomString'
    dynamic user = args['user'];
    String randomString = args['randomString'];

    // User? args = ModalRoute.of(context)?.settings.arguments as User;
    // String nome = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            productProvider.removeAllProducts();
            Navigator.of(context)
                .pushReplacementNamed(Routes.HOME, arguments: user);
          },
        ),
      ),
      body: VendaWidget(nome: randomString, user: user),
    );
  }
}
