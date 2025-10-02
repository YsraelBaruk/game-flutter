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
      Item(nome: 'Poção de Vida', descricao: 'Recupera 1 vida.', preco: 50),
      Item(nome: 'Espada Curta', descricao: 'Aumenta o ataque.', preco: 150),
      Item(nome: 'Escudo de Madeira', descricao: 'Aumenta a defesa.', preco: 120),
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
            subtitle: Text('${item.descricao} - Preço: ${item.preco} moedas'),
            onTap: () => _comprarItem(context, playerState, item),
          );
        },
      ),
    );
  }
}