import '../models/personagem.dart';
import '../models/item.dart';
import '../models/missao.dart';
import '../models/cidade.dart';

class SaveLoadService {
  Future<void> saveGame(Personagem personagem) async {
    print('--- JOGO SALVO (simulação) ---');
    print('Personagem: ${personagem.nome}');
    print('Nível: ${personagem.nivel}');
    print('HP: ${personagem.hp}/${personagem.maxHp}');
    print('XP: ${personagem.xp}/${personagem.proximoNivelXp}');
    print('---------------------------------');
  }

  Future<Personagem?> loadGame() async {
    print('--- CARREGANDO JOGO (simulação) ---');
    
    // Simulação de carregamento - retorna um personagem de exemplo
    return Personagem(
      nome: 'Herói Carregado',
      imagem: 'assets/hero.png',
      itens: [Item(nome: 'Espada de Ferro', preco: 100, descricao: 'Uma espada confiável')],
      missao: Missao(descricao: 'Continuar a aventura onde parou'),
      cidade: Cidade(nome: 'Vila Inicial'),
      nivel: 5,
      hp: 120,
      maxHp: 120,
      mana: 60,
      maxMana: 60,
      ataque: 15,
      defesa: 8,
      xp: 250,
      proximoNivelXp: 500,
    );
  }
}
