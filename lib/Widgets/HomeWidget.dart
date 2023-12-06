import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdv_project_teste_1/Models/listaVendasTeste.dart';
import 'package:pdv_project_teste_1/routes/routes.dart';
import 'package:pdv_project_teste_1/service/vendaService.dart';

import '../Models/User.dart';
import '../Models/Venda.dart';

class HomeWidget extends StatelessWidget {
  User user;
  HomeWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("00.00");
    VendaService vendaService = new VendaService();
    double _vendas = 0;
    int _vendasCanceladas = 2;
    List<Venda> _listVendas = [];
    var vendasListService = vendaService.getVenda().then((value) {
      if (value != null) {
        value.forEach((element) {
          DateTime dataElement = element.getDataVenda;
          if (dataElement.add(Duration(hours: 24)).isAfter(DateTime.now())) {
            _vendas += element.getValor;
            _listVendas.add(element);
          }
        });
      } else {}
    });

    String generateRandomString(int len) {
      var r = Random();
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
          .join();
    }

    return FutureBuilder(
      future: vendasListService,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: AlertDialog(
              title: Text("Contate o Suporte"),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.error.toString()),
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Hoje",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                color: Colors.blueAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Vendas concluidas Hoje",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "R\$ ${formatter.format(_vendas)}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: Card(
                            //     color: Colors.redAccent,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(15.0),
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           const Text(
                            //             "Vendas canceladas",
                            //             style: TextStyle(fontSize: 18),
                            //           ),
                            //           Text(
                            //             _vendasCanceladas.toString(),
                            //             style: const TextStyle(fontSize: 18),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Text(
                    "Vendas de Hoje",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        Routes.VENDAS_HOJE,
                        arguments: {'listaVendas': _listVendas, 'user': user},
                      );
                    },
                    child: Text("Vizualizar vendas"),
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.VENDA,
                          arguments: {
                            'user': user,
                            'randomString': generateRandomString(5)
                          });
                    },
                    child: const Text(
                      "Iniciar Venda",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
