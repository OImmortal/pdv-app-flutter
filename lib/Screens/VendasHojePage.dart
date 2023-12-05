import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../Models/Venda.dart';
import '../Models/listaVendasTeste.dart';

class VendasHojePage extends StatelessWidget {
  const VendasHojePage({super.key});

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("00.00");
    DateFormat dateFormatter = DateFormat("dd/M/yyyy");
    List<Venda>? args =
        ModalRoute.of(context)!.settings.arguments as List<Venda>?;

    List<Venda> _vendasHoje = [];
    args!.forEach((element) {
      DateTime dataElement = element.getDataVenda;
      if (dataElement.add(Duration(hours: 24)).isAfter(DateTime.now())) {
        _vendasHoje.add(element);
      }
    });

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _vendasHoje.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            child: ListTile(
              tileColor: Colors.grey.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_vendasHoje[index].getNomeVenda),
                    Text(
                        "R\$ ${formatter.format(_vendasHoje[index].getValor)}"),
                    Text(dateFormatter.format(_vendasHoje[index].getDataVenda)),
                  ],
                ),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
