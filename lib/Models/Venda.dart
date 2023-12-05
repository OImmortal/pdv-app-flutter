import 'Produto.dart';
import 'User.dart';

class Venda {
  String _nomeVenda;
  double _valor;
  List<dynamic> _listProdutos;
  String _nomeComprador;
  DateTime _dataVenda;
  User? _vendedor;

  Venda({
    required nomeVenda,
    required valor,
    required listaProdutos,
    required nomeComprador,
    required dataVenda,
    required vendedor,
  })  : this._nomeVenda = nomeVenda,
        this._valor = valor,
        this._listProdutos = listaProdutos,
        this._nomeComprador = nomeComprador,
        this._dataVenda = dataVenda,
        this._vendedor = vendedor;

  Venda.semVendedor({
    required nomeVenda,
    required valor,
    required listaProdutos,
    required nomeComprador,
    required dataVenda,
  })  : this._nomeVenda = nomeVenda,
        this._valor = valor,
        this._listProdutos = listaProdutos,
        this._nomeComprador = nomeComprador,
        this._dataVenda = dataVenda;

  String get getNomeVenda {
    return _nomeVenda;
  }

  double get getValor {
    return _valor;
  }

  List<Produto> get getListProduto {
    return [..._listProdutos];
  }

  String get getNomeComprador {
    return _nomeComprador;
  }

  String get getNomeVendedor {
    return _vendedor!.getEmail.toString();
  }

  DateTime get getDataVenda {
    return _dataVenda;
  }
}
