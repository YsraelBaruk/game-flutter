import 'package:flutter/material.dart';
import '../models/personagem.dart';
import 'personagens_screen.dart';
import 'itens_screen.dart';
import 'missoes_screen.dart';
import 'cidades_screen.dart';
import '../widgets/app_bottom_bar.dart';

class MainGameScreen extends StatefulWidget {
  final Personagem personagem;

  const MainGameScreen({super.key, required this.personagem});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  int _currentIndex = 0; // Inicia na tela de personagens

  // Lista de widgets para o corpo da tela
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Inicializa a lista de telas, passando o personagem quando necessário
    _screens = [
      PersonagensContent(personagemPrincipal: widget.personagem),
      const ItensContent(),
      const MissoesContent(),
      const CidadesContent(),
    ];
  }

  String _getCurrentTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Personagem';
      case 1:
        return 'Inventário';
      case 2:
        return 'Missões';
      case 3:
        return 'Cidades';
      default:
        return 'RPG';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getCurrentTitle()),
        automaticallyImplyLeading: false, // Remove o botão de voltar
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
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
