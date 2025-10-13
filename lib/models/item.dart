enum TipoItem { arma, armadura, consumivel, especial }

enum EfeitoItem {
  curaHp,
  curaMana,
  aumentaAtaque,
  aumentaDefesa,
  aumentaHpMaximo,
  aumentaManaMaximo,
  danoExtra,
  protecaoExtra,
}

class Item {
  final String nome;
  final int precoCompra;
  final int precoVenda;
  final String descricao;
  final TipoItem tipo;
  final EfeitoItem? efeito;
  final int? valorEfeito;
  final int? duracaoEfeito; // Para efeitos temporários
  final int quantidade;
  final bool podeUsarEmBatalha;

  Item({
    required this.nome,
    this.precoCompra = 0,
    this.precoVenda = 0,
    this.descricao = '',
    this.tipo = TipoItem.especial,
    this.efeito,
    this.valorEfeito,
    this.duracaoEfeito,
    this.quantidade = 1,
    this.podeUsarEmBatalha = false,
  });

  // Construtor para compatibilidade
  Item.simples({required this.nome, int preco = 0, this.descricao = ''})
    : precoCompra = preco,
      precoVenda = (preco * 0.5).round(),
      tipo = TipoItem.especial,
      efeito = null,
      valorEfeito = null,
      duracaoEfeito = null,
      quantidade = 1,
      podeUsarEmBatalha = false;

  // Construtor para criar cópia com quantidade atualizada
  Item copyWith({
    String? nome,
    int? precoCompra,
    int? precoVenda,
    String? descricao,
    TipoItem? tipo,
    EfeitoItem? efeito,
    int? valorEfeito,
    int? duracaoEfeito,
    int? quantidade,
    bool? podeUsarEmBatalha,
  }) {
    return Item(
      nome: nome ?? this.nome,
      precoCompra: precoCompra ?? this.precoCompra,
      precoVenda: precoVenda ?? this.precoVenda,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
      efeito: efeito ?? this.efeito,
      valorEfeito: valorEfeito ?? this.valorEfeito,
      duracaoEfeito: duracaoEfeito ?? this.duracaoEfeito,
      quantidade: quantidade ?? this.quantidade,
      podeUsarEmBatalha: podeUsarEmBatalha ?? this.podeUsarEmBatalha,
    );
  }

  // Getter para compatibilidade com código antigo
  int get preco => precoCompra;
}
