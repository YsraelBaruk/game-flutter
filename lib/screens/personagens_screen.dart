import 'package:flutter/material.dart';
import 'package:ticket_personagen/models/personagem.dart';
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
  final Personagem? personagemPrincipal;
  
  const PersonagensContent({super.key, this.personagemPrincipal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (personagemPrincipal != null) ...[
            Card(
              color: Colors.deepPurple.withOpacity(0.1),
              child: ListTile(
                leading: const Icon(Icons.person, size: 40, color: Colors.deepPurple),
                title: Text('Seu Personagem: ${personagemPrincipal!.nome}'),
                subtitle: Text('Nível: ${personagemPrincipal!.nivel} | HP: ${personagemPrincipal!.hp}/${personagemPrincipal!.maxHp}'),
                trailing: const Icon(Icons.star, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Outros Personagens:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
          Expanded(
            child: ListView.builder(
              itemCount: personagens.length,
              itemBuilder: (context, index) {
                final personagem = personagens[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
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
            ),
          ),
        ],
      ),
    );
  }
}
