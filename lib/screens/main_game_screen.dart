import 'package:flutter/material.dart';
import 'personagens_screen.dart';
import 'itens_screen.dart';
import 'missoes_screen.dart';
import 'cidades_screen.dart';
import '../widgets/app_bottom_bar.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  int _currentIndex = -1; // -1 para tela inicial

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return const PersonagensContent();
      case 1:
        return const ItensContent();
      case 2:
        return const MissoesContent();
      case 3:
        return const CidadesContent();
      default:
        return const Center(
          child: Text(
            'Bem-vindo!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  String _getCurrentTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Personagens';
      case 1:
        return 'Itens';
      case 2:
        return 'Missões';
      case 3:
        return 'Cidades';
      default:
        return 'Tela Inicial';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getCurrentTitle()),
      ),
      body: _getCurrentScreen(),
      bottomNavigationBar: AppBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}