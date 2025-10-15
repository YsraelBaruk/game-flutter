import '../models/item.dart';

List<Item> itensDisponiveis = [
  Item(nome: 'Espada', preco: 50, descricao: 'Aumenta ataque', tipo: TipoItem.buffAtaque, valorEfeito: 3, consumivel: false),
  Item(nome: 'Poção', preco: 20, descricao: 'Cura 20 HP', tipo: TipoItem.curaHp, valorEfeito: 20),
  Item(nome: 'Escudo', preco: 40, descricao: 'Aumenta defesa', tipo: TipoItem.buffDefesa, valorEfeito: 2, consumivel: false),
  Item(nome: 'Adaga', preco: 30, descricao: 'Pequeno aumento de ataque', tipo: TipoItem.buffAtaque, valorEfeito: 2, consumivel: false),
  Item(nome: 'Poção de Vida', preco: 25, descricao: 'Cura 30 HP', tipo: TipoItem.curaHp, valorEfeito: 30),
];
