import 'package:flutter/material.dart';

import '../Models/Produto.dart';

class ProductProvider extends ChangeNotifier {
  List<Produto> _listOfProduct = [];

  List<Produto> get listOfProduct => [..._listOfProduct];

  void addProduct(Produto produto) {
    bool produtoJaExiste = false;

    for (Produto element in _listOfProduct) {
      if (element.nome == produto.nome) {
        element.quantidade++;
        produtoJaExiste = true;
      }
    }

    if (produtoJaExiste == false) {
      _listOfProduct.add(produto);
    }
    notifyListeners();
  }

  void removeProduct(Produto produto) {
    _listOfProduct.remove(produto);
    notifyListeners();
  }

  void removeAllProducts() {
    _listOfProduct.clear();
    notifyListeners();
  }
}
