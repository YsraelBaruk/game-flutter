// lib/screens/new_game_screen.dart
import 'package:flutter/material.dart';
import 'main_game_screen.dart'; // Supondo que a tela principal do jogo seja esta

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Jogo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Lógica para criar um novo personagem
                // Após criar, navega para a tela principal do jogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainGameScreen()),
                );
              },
              child: const Text('Criar Personagem'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para escolher um personagem pré-desenvolvido
                // Após escolher, navega para a tela principal do jogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainGameScreen()),
                );
              },
              child: const Text('Escolher Personagem Pré-desenvolvido'),
            ),
          ],
        ),
      ),
    );
  }
}