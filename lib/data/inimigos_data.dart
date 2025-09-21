import '../models/inimigo.dart';

List<Inimigo> inimigosDisponiveis = [
  Inimigo(
    nome: 'Goblin',
    hp: 30,
    ataque: 5,
    defesa: 2,
    fraqueza: MagiaTipo.Fogo,
  ),
  Inimigo(
    nome: 'Esqueleto',
    hp: 50,
    ataque: 8,
    defesa: 4,
    fraqueza: MagiaTipo.Raio,
  ),
  Inimigo(
    nome: 'Lobo de Gelo',
    hp: 40,
    ataque: 7,
    defesa: 3,
    fraqueza: MagiaTipo.Fogo,
  ),
];
