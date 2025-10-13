import '../models/item.dart';
import '../models/personagem.dart';

class EfeitoTemporario {
  final EfeitoItem tipo;
  final int valor;
  final int duracao;
  int turnosRestantes;

  EfeitoTemporario({
    required this.tipo,
    required this.valor,
    required this.duracao,
  }) : turnosRestantes = duracao;

  bool get ativo => turnosRestantes > 0;

  void passarTurno() {
    if (turnosRestantes > 0) {
      turnosRestantes--;
    }
  }
}

class ItemService {
  /// Aplica o efeito de um item ao personagem
  static Map<String, dynamic> usarItem(Item item, Personagem personagem) {
    final resultado = <String, dynamic>{
      'sucesso': false,
      'mensagem': '',
      'efeitosAplicados': <String>[],
    };

    if (item.efeito == null || item.valorEfeito == null) {
      resultado['mensagem'] = 'Este item não tem efeitos especiais.';
      return resultado;
    }

    switch (item.efeito!) {
      case EfeitoItem.curaHp:
        final cura = item.valorEfeito!;
        final hpAntes = personagem.hp;
        personagem.hp = (personagem.hp + cura).clamp(0, personagem.maxHp);
        final hpCurado = personagem.hp - hpAntes;
        resultado['sucesso'] = true;
        resultado['mensagem'] = 'Restaurou $hpCurado HP!';
        resultado['efeitosAplicados'].add('HP: +$hpCurado');

      case EfeitoItem.curaMana:
        final cura = item.valorEfeito!;
        final manaAntes = personagem.mana;
        personagem.mana = (personagem.mana + cura).clamp(0, personagem.maxMana);
        final manaCurada = personagem.mana - manaAntes;
        resultado['sucesso'] = true;
        resultado['mensagem'] = 'Restaurou $manaCurada Mana!';
        resultado['efeitosAplicados'].add('Mana: +$manaCurada');

      case EfeitoItem.aumentaHpMaximo:
        personagem.maxHp += item.valorEfeito!;
        personagem.hp += item.valorEfeito!; // Também aumenta HP atual
        resultado['sucesso'] = true;
        resultado['mensagem'] = 'HP máximo aumentou em ${item.valorEfeito}!';
        resultado['efeitosAplicados'].add('HP Máximo: +${item.valorEfeito}');

      case EfeitoItem.aumentaManaMaximo:
        personagem.maxMana += item.valorEfeito!;
        personagem.mana += item.valorEfeito!; // Também aumenta Mana atual
        resultado['sucesso'] = true;
        resultado['mensagem'] = 'Mana máxima aumentou em ${item.valorEfeito}!';
        resultado['efeitosAplicados'].add('Mana Máxima: +${item.valorEfeito}');

      case EfeitoItem.aumentaAtaque:
        personagem.ataque += item.valorEfeito!;
        resultado['sucesso'] = true;
        resultado['mensagem'] = 'Ataque aumentou em ${item.valorEfeito}!';
        resultado['efeitosAplicados'].add('Ataque: +${item.valorEfeito}');

      case EfeitoItem.aumentaDefesa:
        personagem.defesa += item.valorEfeito!;
        resultado['sucesso'] = true;
        resultado['mensagem'] = 'Defesa aumentou em ${item.valorEfeito}!';
        resultado['efeitosAplicados'].add('Defesa: +${item.valorEfeito}');

      case EfeitoItem.danoExtra:
      case EfeitoItem.protecaoExtra:
        // Estes efeitos são temporários e serão aplicados durante a batalha
        resultado['sucesso'] = true;
        resultado['mensagem'] = 'Efeito temporário aplicado!';
        resultado['efeitosAplicados'].add(
          'Efeito temporário: ${item.efeito!.name}',
        );
    }

    return resultado;
  }

  /// Verifica se um item pode ser usado em batalha
  static bool podeUsarEmBatalha(Item item) {
    return item.podeUsarEmBatalha &&
        item.efeito != null &&
        item.valorEfeito != null;
  }

  /// Retorna itens que podem ser usados em batalha
  static List<Item> getItensUsaveisEmBatalha(List<Item> itens) {
    return itens.where((item) => podeUsarEmBatalha(item)).toList();
  }

  /// Calcula o valor de venda de um item
  static int calcularValorVenda(Item item) {
    return item.precoVenda > 0
        ? item.precoVenda
        : (item.precoCompra * 0.5).round();
  }

  /// Verifica se o personagem pode comprar um item
  static bool podeComprar(Personagem personagem, Item item) {
    // Assumindo que o personagem tem um sistema de moedas
    // Por enquanto, sempre retorna true
    return true;
  }

  /// Verifica se o personagem pode vender um item
  static bool podeVender(Item item) {
    return item.precoVenda > 0;
  }

  /// Retorna informações detalhadas sobre um item
  static Map<String, dynamic> obterInfoItem(Item item) {
    return {
      'nome': item.nome,
      'descricao': item.descricao,
      'tipo': item.tipo.name,
      'precoCompra': item.precoCompra,
      'precoVenda': calcularValorVenda(item),
      'quantidade': item.quantidade,
      'podeUsarEmBatalha': item.podeUsarEmBatalha,
      'efeito': item.efeito?.name,
      'valorEfeito': item.valorEfeito,
      'duracaoEfeito': item.duracaoEfeito,
    };
  }
}
