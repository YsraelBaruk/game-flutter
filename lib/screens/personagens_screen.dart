import 'package:flutter/material.dart';
import '../data/personagens_data.dart';
import 'personagem_detail_screen.dart'; // Importe a nova tela

class PersonagensScreen extends StatelessWidget {
  const PersonagensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
      ),
      body: ListView.builder(
        itemCount: personagens.length,
        itemBuilder: (context, index) {
          final personagem = personagens[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              // leading: Image.asset(personagem.imagem, width: 50, height: 50, fit: BoxFit.cover),
              leading: const Icon(Icons.person, size: 40),
              title: Text(personagem.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Nível: ${personagem.nivel} | HP: ${personagem.hp}/${personagem.maxHp}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonagemDetailScreen(personagem: personagem)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PersonagensContent extends StatelessWidget {
  const PersonagensContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: personagens.length,
      itemBuilder: (context, index) {
        final personagem = personagens[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.person, size: 40),
            title: Text(personagem.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Nível: ${personagem.nivel} | HP: ${personagem.hp}/${personagem.maxHp}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonagemDetailScreen(personagem: personagem)),
              );
            },
          ),
        );
      },
    );
  }
}
