import 'item.dart';
import 'missao.dart';
import 'cidade.dart';

class Personagem {
  final String nome;
  final String imagem;
  List<Item> itens;
  final Missao missao;
  final Cidade cidade;
  
  int maxHp;
  int hp;
  int maxMana;
  int mana;
  int xp;
  int proximoNivelXp;
  int nivel;
  int ataque;
  int defesa;

  Personagem({
    required this.nome,
    required this.imagem,
    required this.itens,
    required this.missao,
    required this.cidade,
    this.maxHp = 100,
    this.hp = 100,
    this.maxMana = 50,
    this.mana = 50,
    this.xp = 0,
    this.proximoNivelXp = 100,
    this.nivel = 1,
    this.ataque = 10,
    this.defesa = 5,
  });
}
