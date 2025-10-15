// lib/screens/shop_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/player_state.dart';
import '../models/item.dart'; // Importe o modelo de Item

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  void _comprarItem(BuildContext context, PlayerState playerState, Item item) {
    if (playerState.comprarItem(item)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.nome} comprado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Moedas insuficientes para comprar ${item.nome}.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var playerState = Provider.of<PlayerState>(context);
    final List<Item> itensAVenda = [
      const Item(nome: 'Poção de Vida', descricao: 'Recupera 30 HP.', preco: 50, tipo: TipoItem.curaHp, valorEfeito: 30),
      const Item(nome: 'Espada Curta', descricao: 'Aumenta o ataque (não consumível).', preco: 150, tipo: TipoItem.buffAtaque, valorEfeito: 4, consumivel: false),
      const Item(nome: 'Escudo de Madeira', descricao: 'Aumenta a defesa (não consumível).', preco: 120, tipo: TipoItem.buffDefesa, valorEfeito: 3, consumivel: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Loja - Moedas: ${playerState.moedas}'),
      ),
      body: ListView.builder(
        itemCount: itensAVenda.length,
        itemBuilder: (context, index) {
          final item = itensAVenda[index];
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(item.nome),
            subtitle: Text('${item.descricao}\nPreço: ${item.preco} • Venda: ${item.precoVenda}'),
            onTap: () => _comprarItem(context, playerState, item),
          );
        },
      ),
    );
  }
}