import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:pdv_project_teste_1/service/vendaService.dart';

import '../Models/User.dart';
import '../Models/Venda.dart';
import '../Models/listaVendasTeste.dart';
import '../routes/routes.dart';

class VendasHojePage extends StatefulWidget {
  const VendasHojePage({super.key});

  @override
  State<VendasHojePage> createState() => _VendasHojePageState();
}

class _VendasHojePageState extends State<VendasHojePage> {
  @override
  Widget build(BuildContext context) {
    VendaService vendaService = new VendaService();
    NumberFormat formatter = NumberFormat("00.00");
    DateFormat dateFormatter = DateFormat("dd/M/yyyy");
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    User user = args['user'];
    List<Venda> _listaVendas = args['listaVendas'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(Routes.HOME, arguments: user);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _listaVendas.length,
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
                    Text(_listaVendas[index].getNomeVenda),
                    Text(
                        "R\$ ${formatter.format(_listaVendas[index].getValor)}"),
                    Text(
                        dateFormatter.format(_listaVendas[index].getDataVenda)),
                  ],
                ),
              ),
              onTap: () {
                final _controllerName = TextEditingController();
                final _controllerValor = TextEditingController();
                final _controllerComprador = TextEditingController();
                DateTime _dataVenda = _listaVendas[index].getDataVenda;
                DateTime _novaData = _listaVendas[index].getDataVenda;

                _controllerName.text = _listaVendas[index].getNomeVenda;
                _controllerValor.text = _listaVendas[index].getValor.toString();
                _controllerComprador.text =
                    _listaVendas[index].getNomeComprador;

                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _controllerName,
                            decoration: InputDecoration(
                              labelText: "Nome da Venda",
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _controllerComprador,
                            decoration: InputDecoration(
                              labelText: "Nome do Comprador",
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _controllerValor,
                            decoration: InputDecoration(
                              labelText: "Valor da Venda",
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () async {
                              DateTime? _picker = await showDatePicker(
                                context: context,
                                initialDate: _dataVenda,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              if (_picker == null) {
                                _picker = DateTime.now();
                                _novaData = _listaVendas[index].getDataVenda;
                              } else {
                                _novaData = _picker;
                                _dataVenda = _novaData;
                              }
                            },
                            icon: Icon(Icons.date_range),
                            label: Text("Selecionar Data"),
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                              onPressed: () {
                                vendaService
                                    .patchVenda(
                                  Venda.pacth(
                                    id: _listaVendas[index].getIdVenda,
                                    nomeVenda: _controllerName.text,
                                    nomeComprador: _controllerComprador.text,
                                    valor:
                                        double.tryParse(_controllerValor.text),
                                    dataVenda: _novaData,
                                  ),
                                )
                                    .whenComplete(() {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacementNamed(
                                    Routes.HOME,
                                    arguments: user,
                                  );
                                });
                              },
                              child: Text("Atualizar Venda"),
                            ),
                          )
                        ],
                      ),
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
