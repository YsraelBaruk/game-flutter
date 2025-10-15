import '../models/personagem.dart';
import '../models/item.dart';
import '../models/missao.dart';
import '../models/cidade.dart';

final List<Personagem> personagens = [
  Personagem(
    nome: 'Viktor Zangeiv',
    imagem: 'assets/viktor.png', 
    itens: [
      Item(nome: 'Luva de Boxe', preco: 35, descricao: 'Melhora socos', tipo: TipoItem.buffAtaque, valorEfeito: 5, consumivel: false),
    ],
    missao: Missao(id: 'm1', descricao: 'Provar a força russa no wrestling mundial.', objetivoTotal: 5),
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
      Item(nome: 'karategi', preco: 25, descricao: 'Traje tradicional', tipo: TipoItem.buffDefesa, valorEfeito: 3, consumivel: false),
      Item(nome: 'Faixa Amarela', preco: 15, descricao: 'Marca de graduação'),
    ],
    missao: Missao(id: 'm2', descricao: 'Difundir o Kyokushin e testar seus limites através de duelos.', objetivoTotal: 7),
    cidade: Cidade(nome: 'Tóquio, Japão'),
    ataque: 12,
    defesa: 6,
  ),
  Personagem(
    nome: 'Bruce Lee',
    imagem: 'assets/bruce.png',
    itens: [
      Item(nome: 'nunchaku', preco: 45, descricao: 'Arma ágil', tipo: TipoItem.buffAtaque, valorEfeito: 4, consumivel: false),
    ],
    missao: Missao(id: 'm3', descricao: 'Aperfeiçoar e difundir o Jeet Kune Do.', objetivoTotal: 6),
    cidade: Cidade(nome: 'Seattle, EUA'),
    ataque: 18,
    defesa: 4,
    maxMana: 70,
    mana: 70,
  ),
];
