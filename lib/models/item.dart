enum TipoItem { arma, armadura, consumivel, especial }

class Item {
  final String nome;
  final int preco;
  final String descricao;
  final TipoItem tipo;
  final int? bonusAtaque;
  final int? bonusDefesa;
  final int? bonusHp;
  final int? bonusMana;
  final int? quantidade; // Para itens consumíveis

  Item({
    required this.nome,
    this.preco = 0,
    this.descricao = '',
    this.tipo = TipoItem.especial,
    this.bonusAtaque,
    this.bonusDefesa,
    this.bonusHp,
    this.bonusMana,
    this.quantidade = 1,
  });

  // Construtor para criar cópia com quantidade atualizada
  Item copyWith({
    String? nome,
    int? preco,
    String? descricao,
    TipoItem? tipo,
    int? bonusAtaque,
    int? bonusDefesa,
    int? bonusHp,
    int? bonusMana,
    int? quantidade,
  }) {
    return Item(
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
      bonusAtaque: bonusAtaque ?? this.bonusAtaque,
      bonusDefesa: bonusDefesa ?? this.bonusDefesa,
      bonusHp: bonusHp ?? this.bonusHp,
      bonusMana: bonusMana ?? this.bonusMana,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}
