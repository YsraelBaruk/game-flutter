enum MagiaTipo { Fogo, Gelo, Raio }

class Inimigo {
  final String nome;
  int hp;
  final int ataque;
  final int defesa;
  final MagiaTipo fraqueza;

  Inimigo({
    required this.nome,
    required this.hp,
    required this.ataque,
    required this.defesa,
    required this.fraqueza,
  });
}
