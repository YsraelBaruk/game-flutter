import '../models/inimigo.dart';

List<Inimigo> inimigosDisponiveis = [
  Inimigo(
    nome: 'Goblin',
    hp: 30,
    ataque: 5,
    defesa: 2,
    fraqueza: MagiaTipo.fogo,
    xpRecompensa: 20,
    moedasRecompensa: 10,
    drops: const [
      InimigoDrop(itemNome: 'Poção', chance: 0.25),
      InimigoDrop(itemNome: 'Adaga', chance: 0.10),
    ],
  ),
  Inimigo(
    nome: 'Esqueleto',
    hp: 50,
    ataque: 8,
    defesa: 4,
    fraqueza: MagiaTipo.raio,
    xpRecompensa: 35,
    moedasRecompensa: 20,
    drops: const [
      InimigoDrop(itemNome: 'Espada', chance: 0.08),
      InimigoDrop(itemNome: 'Poção de Vida', chance: 0.18),
    ],
  ),
  Inimigo(
    nome: 'Lobo de Gelo',
    hp: 40,
    ataque: 7,
    defesa: 3,
    fraqueza: MagiaTipo.fogo,
    xpRecompensa: 28,
    moedasRecompensa: 18,
    drops: const [
      InimigoDrop(itemNome: 'Escudo', chance: 0.12),
      InimigoDrop(itemNome: 'Poção', chance: 0.22),
    ],
  ),
];
