import 'dart:convert';

import 'package:pdv_project_teste_1/Models/Produto.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Produto>?> getProductList() async {
    Uri url = Uri.parse(
        "https://pdv-teste-project-default-rtdb.firebaseio.com/produtos.json");

    List<Produto>? _productList = [];

    final response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        json.values.forEach((element) {
          if (element['nome'] != null && element['valor'] != null) {
            String nome = element['nome'].toString();
            double? valor = double.tryParse(element['valor'].toString());

            if (valor != null) {
              _productList.add(
                Produto(
                  nome: nome,
                  valor: valor,
                ),
              );
            }
          }
        });
        return _productList;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
