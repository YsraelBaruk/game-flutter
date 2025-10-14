import '../models/personagem.dart';
import '../models/item.dart';
import '../models/missao.dart';
import '../models/cidade.dart';
import '../models/inventario.dart';

final List<Personagem> personagens = [
  Personagem(
    nome: 'Viktor Zangeiv',
    imagem: 'assets/viktor.png',
    itens: [
      Item(
        nome: 'Luva de Boxe',
        precoCompra: 35,
        precoVenda: 17,
        descricao: 'Luva especial para boxe.',
        tipo: TipoItem.arma,
        efeito: EfeitoItem.aumentaAtaque,
        valorEfeito: 2,
      ),
    ],
    missao: Missao(
      nome: 'Prova de Força',
      descricao: 'Provar a força russa no wrestling mundial.',
      objetivos: [
        ObjetivoMissao(
          tipo: TipoMissao.derrotarInimigos,
          quantidadeNecessaria: 5,
        ),
      ],
      recompensaXp: 100,
      recompensaMoedas: 50,
    ),
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
      Item(
        nome: 'Karategi',
        precoCompra: 25,
        precoVenda: 12,
        descricao: 'Uniforme tradicional de karatê.',
        tipo: TipoItem.armadura,
        efeito: EfeitoItem.aumentaDefesa,
        valorEfeito: 1,
      ),
      Item.simples(
        nome: 'Faixa Amarela',
        preco: 15,
        descricao: 'Faixa de graduação amarela.',
      ),
    ],
    missao: Missao(
      nome: 'Caminho do Kyokushin',
      descricao:
          'Difundir o Kyokushin e testar seus limites através de duelos.',
      objetivos: [
        ObjetivoMissao(tipo: TipoMissao.ganharXp, quantidadeNecessaria: 200),
        ObjetivoMissao(tipo: TipoMissao.usarItens, quantidadeNecessaria: 3),
      ],
      recompensaXp: 150,
      recompensaMoedas: 75,
    ),
    cidade: Cidade(nome: 'Tóquio, Japão'),
    ataque: 12,
    defesa: 6,
  ),
  Personagem(
    nome: 'Bruce Lee',
    imagem: 'assets/bruce.png',
    itens: [
      Item(
        nome: 'Nunchaku',
        precoCompra: 45,
        precoVenda: 22,
        descricao: 'Arma tradicional de duas partes.',
        tipo: TipoItem.arma,
        efeito: EfeitoItem.aumentaAtaque,
        valorEfeito: 4,
      ),
    ],
    missao: Missao(
      nome: 'Jeet Kune Do',
      descricao: 'Aperfeiçoar e difundir o Jeet Kune Do.',
      objetivos: [
        ObjetivoMissao(
          tipo: TipoMissao.completarBatalhas,
          quantidadeNecessaria: 10,
        ),
        ObjetivoMissao(tipo: TipoMissao.coletarItens, quantidadeNecessaria: 8),
      ],
      recompensaXp: 200,
      recompensaMoedas: 100,
    ),
    cidade: Cidade(nome: 'Seattle, EUA'),
    ataque: 18,
    defesa: 4,
    maxMana: 70,
    mana: 70,
  ),
];
