import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pdv_project_teste_1/Widgets/HomeWidget.dart';
import 'package:pdv_project_teste_1/routes/routes.dart';

import '../Models/User.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? args = ModalRoute.of(context)?.settings.arguments as User;

    if (args != null) {
      return Scaffold(
        appBar: AppBarWidget(args, context),
        body: HomeWidget(user: args),
      );
    } else {
      return Scaffold(
        body: Text("Contate o Suporte"),
      );
    }
  }

  AppBar AppBarWidget(User args, BuildContext context) {
    return AppBar(
      title: Text(args.getEmail),
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            if (value == 2) {
              Navigator.of(context).pushReplacementNamed(Routes.LOGIN_PAGE);
            }
          },
          itemBuilder: (context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 1,
              child: Text('Configurações'),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text('Sair'),
            ),
          ],
        ),
      ],
    );
  }
}
