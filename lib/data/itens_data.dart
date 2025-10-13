import '../models/item.dart';

List<Item> itensDisponiveis = [
  // Armas
  Item(
    nome: 'Espada de Ferro',
    preco: 50,
    descricao: 'Uma espada básica de ferro.',
    tipo: TipoItem.arma,
    bonusAtaque: 3,
  ),
  Item(
    nome: 'Machado Orc',
    preco: 80,
    descricao: 'Machado pesado usado por guerreiros orcs.',
    tipo: TipoItem.arma,
    bonusAtaque: 5,
  ),
  Item(
    nome: 'Adaga Afiada',
    preco: 30,
    descricao: 'Adaga leve e rápida.',
    tipo: TipoItem.arma,
    bonusAtaque: 2,
  ),
  Item(
    nome: 'Espada Infernal',
    preco: 200,
    descricao: 'Espada forjada nas chamas do inferno.',
    tipo: TipoItem.arma,
    bonusAtaque: 10,
  ),
  Item(
    nome: 'Cajado Maldito',
    preco: 150,
    descricao: 'Cajado carregado com energia sombria.',
    tipo: TipoItem.arma,
    bonusAtaque: 8,
    bonusMana: 20,
  ),

  // Armaduras
  Item(
    nome: 'Armadura de Couro',
    preco: 40,
    descricao: 'Armadura básica de couro.',
    tipo: TipoItem.armadura,
    bonusDefesa: 3,
  ),
  Item(
    nome: 'Escudo de Madeira',
    preco: 25,
    descricao: 'Escudo simples de madeira.',
    tipo: TipoItem.armadura,
    bonusDefesa: 2,
  ),
  Item(
    nome: 'Armadura Demoníaca',
    preco: 300,
    descricao: 'Armadura forjada com metal infernal.',
    tipo: TipoItem.armadura,
    bonusDefesa: 12,
    bonusHp: 50,
  ),

  // Consumíveis
  Item(
    nome: 'Poção Pequena',
    preco: 15,
    descricao: 'Restaura 20 HP.',
    tipo: TipoItem.consumivel,
    quantidade: 1,
  ),
  Item(
    nome: 'Poção de Vida',
    preco: 25,
    descricao: 'Restaura 50 HP.',
    tipo: TipoItem.consumivel,
    quantidade: 1,
  ),
  Item(
    nome: 'Poção de Mana',
    preco: 20,
    descricao: 'Restaura 30 Mana.',
    tipo: TipoItem.consumivel,
    quantidade: 1,
  ),
  Item(
    nome: 'Poção de Força',
    preco: 50,
    descricao: 'Aumenta temporariamente o ataque.',
    tipo: TipoItem.consumivel,
    quantidade: 1,
  ),

  // Itens Especiais
  Item(
    nome: 'Escama de Dragão',
    preco: 100,
    descricao: 'Escama rara de dragão.',
    tipo: TipoItem.especial,
  ),
  Item(
    nome: 'Cristal de Poder',
    preco: 200,
    descricao: 'Cristal carregado com energia mágica.',
    tipo: TipoItem.especial,
    bonusMana: 30,
  ),
  Item(
    nome: 'Orbe Sombrio',
    preco: 150,
    descricao: 'Orbe pulsante com energia sombria.',
    tipo: TipoItem.especial,
    bonusAtaque: 5,
    bonusMana: 15,
  ),
  Item(
    nome: 'Moedas Antigas',
    preco: 5,
    descricao: 'Moedas antigas de valor histórico.',
    tipo: TipoItem.especial,
  ),
];
