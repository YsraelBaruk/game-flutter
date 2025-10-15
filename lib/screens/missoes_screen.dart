import 'package:flutter/material.dart';
import '../data/personagens_data.dart';
import '../models/missao.dart';

class MissoesScreen extends StatelessWidget {
  const MissoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = personagens.length;
    final concluidas = personagens.where((p) => p.missao.concluida).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Missões'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Concluídas: $concluidas/$total', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: personagens.length,
              itemBuilder: (context, index) {
                final personagem = personagens[index];
                final Missao m = personagem.missao;
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(personagem.nome, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(m.descricao),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: m.progressoPercent),
                        const SizedBox(height: 6),
                        Text('Progresso: ${m.progressoAtual}/${m.objetivoTotal} • ${m.concluida ? 'Concluída' : 'Em andamento'}'),
                      ],
                    ),
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

class MissoesContent extends StatelessWidget {
  const MissoesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final total = personagens.length;
    final concluidas = personagens.where((p) => p.missao.concluida).length;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Concluídas: $concluidas/$total', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: personagens.length,
            itemBuilder: (context, index) {
              final personagem = personagens[index];
              final Missao m = personagem.missao;
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(personagem.nome, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(m.descricao),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: m.progressoPercent),
                      const SizedBox(height: 6),
                      Text('Progresso: ${m.progressoAtual}/${m.objetivoTotal} • ${m.concluida ? 'Concluída' : 'Em andamento'}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}