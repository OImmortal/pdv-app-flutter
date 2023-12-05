import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/Produto.dart';
import '../Models/Venda.dart';

class VendaService {
  Future<void> postVenda(Venda venda) async {
    Uri url = Uri.parse(
        "https://pdv-teste-project-default-rtdb.firebaseio.com/vendas/.json");

    List<Produto> produtos = venda.getListProduto;

    List<Map<String, dynamic>> listaProdutosJson =
        produtos.map((produto) => produto.toJson()).toList();

    var body = jsonEncode({
      "nomeVenda": venda.getNomeVenda,
      "dataVenda": venda.getDataVenda.toIso8601String(),
      "listaProdutos": listaProdutosJson,
      "nomeComprador": venda.getNomeComprador,
      "nomeVendedor": venda.getNomeVendedor,
      "valorTotal": venda.getValor,
    });

    print(body);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print(response.statusCode);
  }

  Future<List<Venda>?> getVenda() async {
    Uri url = Uri.parse(
        "https://pdv-teste-project-default-rtdb.firebaseio.com/vendas.json");
    final response = await http.get(url);

    List<Venda> _listVendas = [];

    try {
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        json.forEach((key, value) {
          if (key != null) {
            // print(value['listaProdutos']);
            double? valor = double.tryParse(value['valorTotal'].toString());

            Venda vendaAdd = Venda.semVendedor(
              nomeVenda: value['nomeVenda'],
              valor: valor,
              listaProdutos: value['listaProdutos'],
              nomeComprador: value['nomeComprador'],
              dataVenda: DateTime.parse(value['dataVenda']),
            );
            _listVendas.add(vendaAdd);
          }
        });
        return _listVendas;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
