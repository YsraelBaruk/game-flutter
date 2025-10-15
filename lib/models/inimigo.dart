enum MagiaTipo { fogo, gelo, raio }

class Inimigo {
  final String nome;
  int hp;
  final int ataque;
  final int defesa;
  final MagiaTipo fraqueza;
  
  // Recompensas ao derrotar
  final int xpRecompensa;
  final int moedasRecompensa;
  
  // Tabela de drops: cada entrada representa um possível drop
  // chance: 0.0 a 1.0; quantidadeMin/Max: faixa de quantidade
  final List<InimigoDrop> drops;

  Inimigo({
    required this.nome,
    required this.hp,
    required this.ataque,
    required this.defesa,
    required this.fraqueza,
    this.xpRecompensa = 25,
    this.moedasRecompensa = 15,
    this.drops = const [],
  });
}

class InimigoDrop {
  final String itemNome;
  final double chance; // 0.0 a 1.0
  final int quantidadeMin;
  final int quantidadeMax;

  const InimigoDrop({
    required this.itemNome,
    required this.chance,
    this.quantidadeMin = 1,
    this.quantidadeMax = 1,
  }) : assert(chance >= 0.0 && chance <= 1.0),
       assert(quantidadeMin >= 0),
       assert(quantidadeMax >= quantidadeMin);
}
