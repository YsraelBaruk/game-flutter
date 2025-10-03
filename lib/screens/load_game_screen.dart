// lib/screens/load_game_screen.dart
import 'package:flutter/material.dart';
import 'main_game_screen.dart';
import '../data/personagens_data.dart';

class LoadGameScreen extends StatelessWidget {
  const LoadGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carregar Jogo'),
      ),
      body: ListView.builder(
        itemCount: 3, // Exemplo com 3 slots de save
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Jogo Salvo ${index + 1}'),
            subtitle: Text('Progresso: ${75 + index * 5}% - Data: 2024-10-26'),
            leading: const Icon(Icons.save),
            onTap: () {
              // Lógica para carregar o jogo selecionado
              // Por enquanto, usa o primeiro personagem da lista
              final personagemCarregado = personagens.first;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainGameScreen(personagem: personagemCarregado),
                ),
              );
            },
          );
        },
      ),
    );
  }
}