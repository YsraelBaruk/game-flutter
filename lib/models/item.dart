enum TipoItem { curaHp, curaMana, buffAtaque, buffDefesa, danoMagico }

class Item {
  final String nome;
  final String descricao;
  final int preco; // preço de compra
  final int precoVenda; // preço de venda
  final TipoItem? tipo; // efeito em batalha
  final int valorEfeito; // magnitude do efeito
  final bool consumivel; // se é consumido ao usar

  const Item({
    required this.nome,
    this.descricao = '',
    this.preco = 0,
    int? precoVenda,
    this.tipo,
    this.valorEfeito = 0,
    this.consumivel = true,
  }) : precoVenda = precoVenda ?? (preco ~/ 2);
}