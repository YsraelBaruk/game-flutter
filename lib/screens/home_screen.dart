import 'package:flutter/material.dart';
import 'personagens_screen.dart';
import 'itens_screen.dart';
import 'missoes_screen.dart';
import 'cidades_screen.dart';
import 'historico_screen.dart'; // Importe a nova tela

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel do Aventureiro'),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavButton(context, const PersonagensScreen(), Icons.person, 'Personagens'),
              _buildNavButton(context, const ItensScreen(), Icons.shopping_bag, 'Itens'),
              _buildNavButton(context, const MissoesScreen(), Icons.flag, 'Missões'),
              _buildNavButton(context, const CidadesScreen(), Icons.location_city, 'Cidades'),
              _buildNavButton(context, const HistoricoScreen(), Icons.history, 'Histórico'), // Novo botão
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, Widget screen, IconData icon, String label) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
