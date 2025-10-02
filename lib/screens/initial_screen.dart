// lib/screens/initial_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'new_game_screen.dart';
import 'load_game_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'RPG de Personagens',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade300,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewGameScreen()),
                );
              },
              child: const Text('Iniciar Jogo do Zero'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoadGameScreen()),
                );
              },
              child: const Text('Carregar Jogo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Fecha o aplicativo
                SystemNavigator.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
              ),
              child: const Text('Sair do Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}