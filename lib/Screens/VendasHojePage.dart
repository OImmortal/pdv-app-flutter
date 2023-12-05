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

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: args!.length,
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
                    Text(args[index].getNomeVenda),
                    Text("R\$ ${formatter.format(args[index].getValor)}"),
                    Text(dateFormatter.format(args[index].getDataVenda)),
                  ],
                ),
              ),
              onTap: () {
                final _controllerName = TextEditingController();
                final _controllerValor = TextEditingController();
                final _controllerComprador = TextEditingController();
                final _controllerVendedor = TextEditingController();

                _controllerName.text = args[index].getNomeVenda;
                // _controllerValor.text = _vendasHoje[index].getValor.toString();
                // _controllerComprador.text = _vendasHoje[index].getNomeComprador;
                // _controllerVendedor.text = _vendasHoje[index].getNomeVendedor;

                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        TextField(
                          controller: _controllerName,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
