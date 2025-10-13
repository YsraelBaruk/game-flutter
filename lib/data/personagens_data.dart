import '../models/personagem.dart';
import '../models/item.dart';
import '../models/missao.dart';
import '../models/cidade.dart';
import '../models/inventario.dart';

final List<Personagem> personagens = [
  Personagem(
    nome: 'Viktor Zangeiv',
    imagem: 'assets/viktor.png',
    inventario: Inventario(
      itens: [
        Item(
          nome: 'Luva de Boxe',
          preco: 35,
          descricao: 'Luva especial para boxe.',
          tipo: TipoItem.arma,
          bonusAtaque: 2,
        ),
      ],
      moedas: Moedas(quantidade: 50),
    ),
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
    inventario: Inventario(
      itens: [
        Item(
          nome: 'Karategi',
          preco: 25,
          descricao: 'Uniforme tradicional de karatê.',
          tipo: TipoItem.armadura,
          bonusDefesa: 1,
        ),
        Item(
          nome: 'Faixa Amarela',
          preco: 15,
          descricao: 'Faixa de graduação amarela.',
          tipo: TipoItem.especial,
        ),
      ],
      moedas: Moedas(quantidade: 30),
    ),
    missao: Missao(
      descricao:
          'Difundir o Kyokushin e testar seus limites através de duelos.',
    ),
    cidade: Cidade(nome: 'Tóquio, Japão'),
    ataque: 12,
    defesa: 6,
  ),
  Personagem(
    nome: 'Bruce Lee',
    imagem: 'assets/bruce.png',
    inventario: Inventario(
      itens: [
        Item(
          nome: 'Nunchaku',
          preco: 45,
          descricao: 'Arma tradicional de duas partes.',
          tipo: TipoItem.arma,
          bonusAtaque: 4,
        ),
      ],
      moedas: Moedas(quantidade: 75),
    ),
    missao: Missao(descricao: 'Aperfeiçoar e difundir o Jeet Kune Do.'),
    cidade: Cidade(nome: 'Seattle, EUA'),
    ataque: 18,
    defesa: 4,
    maxMana: 70,
    mana: 70,
  ),
];
