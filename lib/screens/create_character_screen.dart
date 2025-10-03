import 'package:flutter/material.dart';
import '../models/personagem.dart';
import '../models/missao.dart';
import '../models/cidade.dart';
import 'main_game_screen.dart';

class CreateCharacterScreen extends StatefulWidget {
  const CreateCharacterScreen({super.key});

  @override
  _CreateCharacterScreenState createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  final _nameController = TextEditingController();

  void _criarPersonagem() {
    // Valida se o nome não está vazio
    if (_nameController.text.trim().isNotEmpty) {
      // Cria uma nova instância de Personagem com os dados do formulário
      final novoPersonagem = Personagem(
        nome: _nameController.text.trim(),
        imagem: 'assets/bruce.png', // Atribui uma imagem padrão para novos personagens
        itens: [], // Começa com um inventário vazio
        missao: Missao(descricao: 'Desbravar o mundo e se tornar uma lenda.'),
        cidade: Cidade(nome: 'Vila Inicial'),
        hp: 100,
        maxHp: 100,
        mana: 50,
        maxMana: 50,
        ataque: 10,
        defesa: 5,
        nivel: 1,
        xp: 0,
        proximoNivelXp: 100,
      );

      // Navega para a tela principal do jogo, passando o personagem recém-criado
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainGameScreen(personagem: novoPersonagem),
        ),
        (route) => false, // Remove todas as telas anteriores da pilha
      );
    } else {
      // Mostra um aviso caso o nome esteja em branco
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um nome para o seu personagem.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Novo Personagem'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Dê um nome ao seu herói',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome do Personagem',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _criarPersonagem,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Iniciar Aventura'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
