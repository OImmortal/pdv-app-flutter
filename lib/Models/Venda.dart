import 'Produto.dart';
import 'User.dart';

class Venda {
  String? _id;
  String? _nomeVenda;
  double? _valor;
  List<dynamic>? _listProdutos;
  String? _nomeComprador;
  DateTime? _dataVenda;
  User? _vendedor;

  Venda({
    required id,
    required nomeVenda,
    required valor,
    required listaProdutos,
    required nomeComprador,
    required dataVenda,
    required vendedor,
  })  : this._id = id,
        this._nomeVenda = nomeVenda,
        this._valor = valor,
        this._listProdutos = listaProdutos,
        this._nomeComprador = nomeComprador,
        this._dataVenda = dataVenda,
        this._vendedor = vendedor;

  Venda.get({
    required id,
    required nomeVenda,
    required valor,
    required listaProdutos,
    required nomeComprador,
    required dataVenda,
  })  : this._id = id,
        this._nomeVenda = nomeVenda,
        this._valor = valor,
        this._listProdutos = listaProdutos,
        this._nomeComprador = nomeComprador,
        this._dataVenda = dataVenda;

  Venda.pacth({
    required id,
    required nomeVenda,
    required nomeComprador,
    required valor,
    required dataVenda,
  })  : this._id = id,
        this._nomeVenda = nomeVenda,
        this._nomeComprador = nomeComprador,
        this._valor = valor,
        this._dataVenda = dataVenda;

  String get getIdVenda {
    return _id!;
  }

  String get getNomeVenda {
    return _nomeVenda!;
  }

  double get getValor {
    return _valor!;
  }

  List<Produto> get getListProduto {
    return [..._listProdutos!];
  }

  String get getNomeComprador {
    return _nomeComprador!;
  }

  String get getNomeVendedor {
    return _vendedor!.getEmail.toString();
  }

  DateTime get getDataVenda {
    return _dataVenda!;
  }
}
