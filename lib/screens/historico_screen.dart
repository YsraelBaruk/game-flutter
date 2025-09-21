import 'package:flutter/material.dart';
import '../services/game_service.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Ações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              gameService.limparHistorico();
            },
            tooltip: 'Limpar Histórico',
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: gameService,
        builder: (context, child) {
          if (gameService.historico.isEmpty) {
            return const Center(child: Text('Nenhuma ação registrada.'));
          }
          return ListView.builder(
            itemCount: gameService.historico.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(gameService.historico[index]),
              );
            },
          );
        },
      ),
    );
  }
}
