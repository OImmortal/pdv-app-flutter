class Produto {
  final String nome;
  final double valor;
  int quantidade = 1;

  Produto({required this.nome, required this.valor});

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'preco': valor,
      'quantidade': quantidade,
    };
  }
}
