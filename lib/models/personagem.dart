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
  
  // Limites máximos
  static const int maxNivel = 50;
  static const int maxHpCap = 999;
  static const int maxManaCap = 500;
  static const int maxAtaqueCap = 200;
  static const int maxDefesaCap = 200;

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

  // Algoritmo de crescimento por nível
  void _aplicarCrescimentoNivel() {
    // Aumentos base por nível
    maxHp = (maxHp + 12).clamp(0, maxHpCap);
    maxMana = (maxMana + 6).clamp(0, maxManaCap);
    ataque = (ataque + 3).clamp(0, maxAtaqueCap);
    defesa = (defesa + 2).clamp(0, maxDefesaCap);
    // Ao subir de nível, recupera totalmente HP/Mana
    hp = maxHp;
    mana = maxMana;
  }

  // Ganhar XP e processar nível
  // Retorna quantidade de níveis ganhos
  int ganharXp(int valor) {
    if (nivel >= maxNivel) {
      // Nível máximo alcançado: apenas impede exceder a barra de XP
      xp = (xp + valor).clamp(0, proximoNivelXp - 1);
      return 0;
    }

    int niveisGanhos = 0;
    xp += valor;
    while (nivel < maxNivel && xp >= proximoNivelXp) {
      xp -= proximoNivelXp;
      nivel++;
      niveisGanhos++;
      // Escalonamento do próximo nível (exponencial suave)
      proximoNivelXp = (proximoNivelXp * 1.35).round().clamp(1, 999999);
      _aplicarCrescimentoNivel();
    }

    if (nivel >= maxNivel) {
      // Se passou do máximo, trava a barra de XP no penúltimo ponto
      xp = xp.clamp(0, proximoNivelXp - 1);
    }
    return niveisGanhos;
  }
}
