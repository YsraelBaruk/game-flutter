import '../models/inimigo.dart';

List<Inimigo> inimigosDisponiveis = [
  // Inimigos Nível 1-3 (Fáceis)
  Inimigo(
    nome: 'Goblin',
    hp: 30,
    ataque: 5,
    defesa: 2,
    fraqueza: MagiaTipo.fogo,
    nivel: 1,
    recompensas: RecompensasInimigo(
      experiencia: 15,
      moedas: 8,
      itensPossiveis: ['Poção Pequena', 'Moedas Antigas'],
      chanceItem: 0.4,
    ),
  ),
  Inimigo(
    nome: 'Esqueleto',
    hp: 50,
    ataque: 8,
    defesa: 4,
    fraqueza: MagiaTipo.raio,
    nivel: 2,
    recompensas: RecompensasInimigo(
      experiencia: 25,
      moedas: 15,
      itensPossiveis: ['Osso Amaldiçoado', 'Poção de Vida'],
      chanceItem: 0.35,
    ),
  ),
  Inimigo(
    nome: 'Lobo de Gelo',
    hp: 40,
    ataque: 7,
    defesa: 3,
    fraqueza: MagiaTipo.fogo,
    nivel: 2,
    recompensas: RecompensasInimigo(
      experiencia: 20,
      moedas: 12,
      itensPossiveis: ['Pele de Lobo', 'Garra Congelada'],
      chanceItem: 0.3,
    ),
  ),

  // Inimigos Nível 3-5 (Médios)
  Inimigo(
    nome: 'Orc Guerreiro',
    hp: 80,
    ataque: 12,
    defesa: 6,
    fraqueza: MagiaTipo.gelo,
    nivel: 3,
    recompensas: RecompensasInimigo(
      experiencia: 40,
      moedas: 25,
      itensPossiveis: ['Machado Orc', 'Armadura de Couro'],
      chanceItem: 0.5,
    ),
  ),
  Inimigo(
    nome: 'Aranha Gigante',
    hp: 60,
    ataque: 10,
    defesa: 5,
    fraqueza: MagiaTipo.fogo,
    nivel: 3,
    recompensas: RecompensasInimigo(
      experiencia: 35,
      moedas: 20,
      itensPossiveis: ['Seda de Aranha', 'Veneno'],
      chanceItem: 0.45,
    ),
  ),
  Inimigo(
    nome: 'Troll da Montanha',
    hp: 120,
    ataque: 15,
    defesa: 8,
    fraqueza: MagiaTipo.raio,
    nivel: 4,
    recompensas: RecompensasInimigo(
      experiencia: 60,
      moedas: 40,
      itensPossiveis: ['Clava de Pedra', 'Pele de Troll'],
      chanceItem: 0.6,
    ),
  ),

  // Inimigos Nível 5+ (Difíceis)
  Inimigo(
    nome: 'Dragão Jovem',
    hp: 200,
    ataque: 25,
    defesa: 12,
    fraqueza: MagiaTipo.gelo,
    nivel: 6,
    recompensas: RecompensasInimigo(
      experiencia: 100,
      moedas: 80,
      itensPossiveis: ['Escama de Dragão', 'Garra de Dragão', 'Poção de Força'],
      chanceItem: 0.8,
    ),
  ),
  Inimigo(
    nome: 'Lich Sombrio',
    hp: 150,
    ataque: 20,
    defesa: 10,
    fraqueza: MagiaTipo.fogo,
    nivel: 7,
    recompensas: RecompensasInimigo(
      experiencia: 120,
      moedas: 100,
      itensPossiveis: ['Cajado Maldito', 'Orbe Sombrio', 'Poção de Mana'],
      chanceItem: 0.9,
    ),
  ),
  Inimigo(
    nome: 'Demônio Infernal',
    hp: 300,
    ataque: 30,
    defesa: 15,
    fraqueza: MagiaTipo.gelo,
    nivel: 8,
    recompensas: RecompensasInimigo(
      experiencia: 200,
      moedas: 150,
      itensPossiveis: [
        'Espada Infernal',
        'Armadura Demoníaca',
        'Cristal de Poder',
      ],
      chanceItem: 1.0,
    ),
  ),
];
