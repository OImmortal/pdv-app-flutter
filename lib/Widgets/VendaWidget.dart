import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:pdv_project_teste_1/Models/Produto.dart';
import 'package:pdv_project_teste_1/Widgets/DropDownMenuWidget.dart';
import 'package:pdv_project_teste_1/routes/routes.dart';
import 'package:pdv_project_teste_1/service/productProvider.dart';
import 'package:pdv_project_teste_1/service/productService.dart';
import 'package:pdv_project_teste_1/service/vendaService.dart';
import 'package:provider/provider.dart';

import '../Models/User.dart';
import '../Models/Venda.dart';

class VendaWidget extends StatefulWidget {
  final String nome;
  final User user;
  const VendaWidget({super.key, required this.nome, required this.user});

  @override
  State<VendaWidget> createState() => _VendaWidgetState();
}

class _VendaWidgetState extends State<VendaWidget> {
  var nomeComprador = TextEditingController();
  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("00.00");
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    ProductService service = new ProductService();
    VendaService vendaService = new VendaService();
    final List<String> _values = [];
    List<Produto>? _tabelaProduto;
    double valorVenda = 0;

    final getProduto = service.getProductList().then((value) {
      _tabelaProduto = value!;
      value.forEach((element) {
        _values.add(element.nome);
      });
    });

    void _addProdutcList(String dropItem) {
      _tabelaProduto!.forEach((element) {
        if (element.nome == dropItem) {
          Produto produtoAdd =
              Produto(nome: element.nome, valor: element.valor);
          productProvider.addProduct(produtoAdd);
        }
      });
    }

    productProvider.listOfProduct.forEach((element) {
      valorVenda += (element.quantidade * element.valor);
    });

    final _formKey = GlobalKey<FormState>();
    return StreamBuilder(
      stream: getProduto.asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          print(snapshot.connectionState);
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(snapshot.connectionState);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.nome,
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade700,
                      filled: true,
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    // validator: (value) {
                    //   if (value!.isEmpty || value.length < 2) {
                    //     return "Nome Inválido";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    controller: nomeComprador,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Comprador",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    readOnly: true,
                    initialValue: formatter.format(valorVenda),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Valor da Venda",
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropDownMenuWidget(
                    values: _values,
                    addProductList: _addProdutcList,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productProvider.listOfProduct.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(productProvider
                                    .listOfProduct[index].quantidade
                                    .toString()),
                                Text(productProvider.listOfProduct[index].nome),
                                Text((productProvider
                                            .listOfProduct[index].valor *
                                        productProvider
                                            .listOfProduct[index].quantidade)
                                    .toString()),
                              ],
                            ),
                            onTap: () {
                              productProvider.removeProduct(
                                  productProvider.listOfProduct[index]);
                            },
                            onLongPress: () {
                              setState(() {
                                productProvider
                                    .listOfProduct[index].quantidade++;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            Venda venda = Venda(
                              nomeVenda: widget.nome,
                              valor: valorVenda,
                              listaProdutos: productProvider.listOfProduct,
                              nomeComprador: nomeComprador.text,
                              dataVenda: DateTime.now(),
                              vendedor: widget.user,
                            );
                            vendaService.postVenda(venda).whenComplete(() {
                              productProvider.removeAllProducts();
                              Navigator.of(context).pushReplacementNamed(
                                Routes.HOME,
                                arguments: widget.user,
                              );
                            });
                            // };
                          },
                          child: Text("Finalizar Venda"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              Routes.HOME,
                              arguments: widget.user,
                            );
                            productProvider.removeAllProducts();
                          },
                          child: Text("Cancelar Venda"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
