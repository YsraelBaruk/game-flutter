import 'package:flutter/material.dart';
import '../data/personagens_data.dart';

class ItensScreen extends StatelessWidget {
  const ItensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventário Geral'),
      ),
      body: ListView.builder(
        itemCount: personagens.length,
        itemBuilder: (context, index) {
          final personagem = personagens[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personagem.nome, 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  const Divider(),
                  if (personagem.itens.isEmpty)
                    const Text('Nenhum item.')
                  else
                    ...personagem.itens.map((item) => ListTile(
                      leading: const Icon(Icons.shield_outlined),
                      title: Text(item.nome),
                    )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
