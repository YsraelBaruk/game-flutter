enum MagiaTipo { fogo, gelo, raio }

class RecompensasInimigo {
  final int experiencia;
  final int moedas;
  final List<String> itensPossiveis;
  final double chanceItem;

  RecompensasInimigo({
    required this.experiencia,
    required this.moedas,
    this.itensPossiveis = const [],
    this.chanceItem = 0.3, // 30% de chance por padrão
  });
}

class Inimigo {
  final String nome;
  int hp;
  final int maxHp;
  final int ataque;
  final int defesa;
  final MagiaTipo fraqueza;
  final RecompensasInimigo recompensas;
  final int nivel;

  Inimigo({
    required this.nome,
    required this.hp,
    required this.ataque,
    required this.defesa,
    required this.fraqueza,
    required this.recompensas,
    this.nivel = 1,
  }) : maxHp = hp;

  // Construtor para criar cópia com HP atualizado
  Inimigo copyWith({
    String? nome,
    int? hp,
    int? ataque,
    int? defesa,
    MagiaTipo? fraqueza,
    RecompensasInimigo? recompensas,
    int? nivel,
  }) {
    return Inimigo(
      nome: nome ?? this.nome,
      hp: hp ?? this.hp,
      ataque: ataque ?? this.ataque,
      defesa: defesa ?? this.defesa,
      fraqueza: fraqueza ?? this.fraqueza,
      recompensas: recompensas ?? this.recompensas,
      nivel: nivel ?? this.nivel,
    );
  }
}
