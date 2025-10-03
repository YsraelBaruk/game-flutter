// lib/screens/new_game_screen.dart
import 'package:flutter/material.dart';
import 'package:ticket_personagen/data/personagens_data.dart';
import './create_character_screen.dart';
import 'main_game_screen.dart';
import '../models/personagem.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  void _startGameWithCharacter(BuildContext context, Personagem personagem) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainGameScreen(personagem: personagem),
      ),
      (route) => false, // Remove todas as telas anteriores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Jogo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navega para a tela de criação de personagem
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateCharacterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Criar Novo Personagem'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Ou escolha um personagem pronto:',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 10),
              // Lista de personagens pré-desenvolvidos
              ...personagens.map((personagem) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(personagem.imagem, width: 40, height: 40),
                      title: Text(personagem.nome),
                      subtitle: Text(personagem.cidade.nome),
                      onTap: () => _startGameWithCharacter(context, personagem),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
