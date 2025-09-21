import '../models/personagem.dart';
import '../models/item.dart';
import '../models/missao.dart';
import '../models/cidade.dart';

final List<Personagem> personagens = [
  Personagem(
    nome: 'Viktor Zangeiv',
    imagem: 'assets/viktor.png', 
    itens: [
      Item(nome: 'Luva de Boxe'),
    ],
    missao: Missao(descricao: 'Provar a força russa no wrestling mundial.'),
    cidade: Cidade(nome: 'Moscou, Rússia'),
    ataque: 15,
    defesa: 8,
    maxHp: 120,
    hp: 120,
  ),
  Personagem(
    nome: 'Mas Oyama',
    imagem: 'assets/oyama.png',
    itens: [
      Item(nome: 'karategi'),
      Item(nome: 'Faixa Amarela'),
    ],
    missao: Missao(descricao: 'Difundir o Kyokushin e testar seus limites através de duelos.'),
    cidade: Cidade(nome: 'Tóquio, Japão'),
    ataque: 12,
    defesa: 6,
  ),
  Personagem(
    nome: 'Bruce Lee',
    imagem: 'assets/bruce.png',
    itens: [
      Item(nome: 'nunchaku'),
    ],
    missao: Missao(descricao: 'Aperfeiçoar e difundir o Jeet Kune Do.'),
    cidade: Cidade(nome: 'Seattle, EUA'),
    ataque: 18,
    defesa: 4,
    maxMana: 70,
    mana: 70,
  ),
];
