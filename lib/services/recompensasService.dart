import 'dart:math';
import '../models/inimigo.dart';
import '../models/item.dart';
import '../models/inventario.dart';
import '../models/personagem.dart';
import '../data/itens_data.dart';

class RecompensasService {
  static final Random _random = Random();

  /// Processa as recompensas de um inimigo derrotado
  static Map<String, dynamic> processarRecompensas(Inimigo inimigo) {
    final recompensas = inimigo.recompensas;
    final resultado = <String, dynamic>{
      'experiencia': recompensas.experiencia,
      'moedas': recompensas.moedas,
      'itens': <Item>[],
    };

    // Verifica se ganhou item baseado na chance
    if (_random.nextDouble() < recompensas.chanceItem) {
      final itemEscolhido = _escolherItemAleatorio(recompensas.itensPossiveis);
      if (itemEscolhido != null) {
        resultado['itens'].add(itemEscolhido);
      }
    }

    return resultado;
  }

  /// Escolhe um item aleatório da lista de itens possíveis
  static Item? _escolherItemAleatorio(List<String> nomesItens) {
    if (nomesItens.isEmpty) return null;

    final nomeEscolhido = nomesItens[_random.nextInt(nomesItens.length)];

    // Procura o item na lista de itens disponíveis
    final itemEncontrado = itensDisponiveis.firstWhere(
      (item) => item.nome == nomeEscolhido,
      orElse: () => Item(
        nome: nomeEscolhido,
        descricao: 'Item encontrado em batalha.',
        tipo: TipoItem.especial,
      ),
    );

    return itemEncontrado;
  }

  /// Aplica as recompensas ao personagem
  static void aplicarRecompensas(
    Personagem personagem,
    Map<String, dynamic> recompensas,
    Inventario inventario,
  ) {
    // Adiciona experiência
    personagem.xp += recompensas['experiencia'] as int;

    // Adiciona moedas
    inventario.moedas.adicionar(recompensas['moedas'] as int);

    // Adiciona itens
    final itens = recompensas['itens'] as List<Item>;
    for (final item in itens) {
      inventario.adicionarItem(item);
    }
  }

  /// Calcula recompensas baseadas no nível do personagem vs inimigo
  static Map<String, dynamic> calcularRecompensasEscaladas(
    Inimigo inimigo,
    int nivelPersonagem,
  ) {
    final recompensas = inimigo.recompensas;
    final diferencaNivel = nivelPersonagem - inimigo.nivel;

    // Multiplicador baseado na diferença de nível
    double multiplicador = 1.0;
    if (diferencaNivel > 0) {
      // Personagem mais forte - menos recompensas
      multiplicador = max(0.5, 1.0 - (diferencaNivel * 0.1));
    } else if (diferencaNivel < 0) {
      // Personagem mais fraco - mais recompensas
      multiplicador = 1.0 + (diferencaNivel.abs() * 0.2);
    }

    return {
      'experiencia': (recompensas.experiencia * multiplicador).round(),
      'moedas': (recompensas.moedas * multiplicador).round(),
      'multiplicador': multiplicador,
    };
  }

  /// Retorna informações sobre as recompensas de um inimigo
  static Map<String, dynamic> obterInfoRecompensas(Inimigo inimigo) {
    return {
      'experiencia': inimigo.recompensas.experiencia,
      'moedas': inimigo.recompensas.moedas,
      'chanceItem': inimigo.recompensas.chanceItem,
      'itensPossiveis': inimigo.recompensas.itensPossiveis,
      'nivel': inimigo.nivel,
    };
  }

  /// Filtra inimigos por nível apropriado para o personagem
  static List<Inimigo> filtrarInimigosPorNivel(
    List<Inimigo> inimigos,
    int nivelPersonagem,
  ) {
    return inimigos.where((inimigo) {
      final diferenca = (inimigo.nivel - nivelPersonagem).abs();
      return diferenca <= 2; // Permite inimigos até 2 níveis de diferença
    }).toList();
  }

  /// Retorna o inimigo mais apropriado para o nível do personagem
  static Inimigo? obterInimigoApropriado(
    List<Inimigo> inimigos,
    int nivelPersonagem,
  ) {
    final inimigosApropriados = filtrarInimigosPorNivel(
      inimigos,
      nivelPersonagem,
    );
    if (inimigosApropriados.isEmpty) return null;

    return inimigosApropriados[_random.nextInt(inimigosApropriados.length)];
  }
}
