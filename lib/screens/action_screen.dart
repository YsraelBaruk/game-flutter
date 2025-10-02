import 'package:flutter/material.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batalha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Representação visual do inimigo ou desafio
            const Icon(Icons.shield, size: 100, color: Colors.red),
            const Text('Inimigo: Goblin', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            // Opções de ação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.gavel),
                  label: const Text('Atacar'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.security),
                  label: const Text('Defender'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on),
                  label: const Text('Habilidade'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.healing),
                  label: const Text('Item'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}