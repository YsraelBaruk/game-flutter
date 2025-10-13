import 'dart:math';
import '../models/inimigo.dart';
import '../models/item.dart';
import '../models/personagem.dart';
import '../data/itens_data.dart';

class RecompensasAcumuladas {
  int experienciaTotal = 0;
  int moedasTotal = 0;
  List<Item> itensColetados = [];

  void adicionarRecompensas(int xp, int moedas, List<Item> itens) {
    experienciaTotal += xp;
    moedasTotal += moedas;
    itensColetados.addAll(itens);
  }

  void limpar() {
    experienciaTotal = 0;
    moedasTotal = 0;
    itensColetados.clear();
  }

  bool get temRecompensas =>
      experienciaTotal > 0 || moedasTotal > 0 || itensColetados.isNotEmpty;
}

class SistemaRecompensas {
  static final Random _random = Random();
  static final RecompensasAcumuladas _recompensasAcumuladas =
      RecompensasAcumuladas();

  /// Processa apenas o drop de itens de um inimigo derrotado
  static List<Item> processarDropItens(Inimigo inimigo) {
    final itensDropados = <Item>[];

    // Sistema simplificado baseado no nome do inimigo
    final chanceDrop = _obterChanceDrop(inimigo.nome);

    if (_random.nextDouble() < chanceDrop) {
      final itemEscolhido = _escolherItemPorInimigo(inimigo.nome);
      if (itemEscolhido != null) {
        itensDropados.add(itemEscolhido);
      }
    }

    return itensDropados;
  }

  /// Adiciona recompensas às acumuladas (sem aplicar ainda)
  static void acumularRecompensas(Inimigo inimigo, List<Item> itensDropados) {
    final xp = _obterXpPorInimigo(inimigo.nome);
    final moedas = _obterMoedasPorInimigo(inimigo.nome);

    _recompensasAcumuladas.adicionarRecompensas(xp, moedas, itensDropados);
  }

  /// Retorna chance de drop baseada no inimigo
  static double _obterChanceDrop(String nomeInimigo) {
    switch (nomeInimigo.toLowerCase()) {
      case 'goblin':
        return 0.4;
      case 'esqueleto':
        return 0.35;
      case 'lobo de gelo':
        return 0.3;
      default:
        return 0.3;
    }
  }

  /// Retorna XP baseado no inimigo
  static int _obterXpPorInimigo(String nomeInimigo) {
    switch (nomeInimigo.toLowerCase()) {
      case 'goblin':
        return 15;
      case 'esqueleto':
        return 25;
      case 'lobo de gelo':
        return 20;
      default:
        return 20;
    }
  }

  /// Retorna moedas baseadas no inimigo
  static int _obterMoedasPorInimigo(String nomeInimigo) {
    switch (nomeInimigo.toLowerCase()) {
      case 'goblin':
        return 8;
      case 'esqueleto':
        return 15;
      case 'lobo de gelo':
        return 12;
      default:
        return 10;
    }
  }

  /// Escolhe item baseado no inimigo
  static Item? _escolherItemPorInimigo(String nomeInimigo) {
    List<String> itensPossiveis;

    switch (nomeInimigo.toLowerCase()) {
      case 'goblin':
        itensPossiveis = ['Poção Pequena', 'Moedas Antigas'];
        break;
      case 'esqueleto':
        itensPossiveis = ['Osso Amaldiçoado', 'Poção de Vida'];
        break;
      case 'lobo de gelo':
        itensPossiveis = ['Pele de Lobo', 'Garra Congelada'];
        break;
      default:
        itensPossiveis = ['Poção Pequena'];
    }

    return _escolherItemAleatorio(itensPossiveis);
  }

  /// Aplica todas as recompensas acumuladas ao personagem
  static Map<String, dynamic> aplicarRecompensasAcumuladas(
    Personagem personagem,
  ) {
    final resultado = {
      'experiencia': _recompensasAcumuladas.experienciaTotal,
      'moedas': _recompensasAcumuladas.moedasTotal,
      'itens': List<Item>.from(_recompensasAcumuladas.itensColetados),
    };

    // Aplica experiência
    personagem.xp += _recompensasAcumuladas.experienciaTotal;

    // Aplica moedas (assumindo que o personagem tem um sistema de moedas)
    // personagem.moedas += _recompensasAcumuladas.moedasTotal;

    // Adiciona itens
    personagem.itens.addAll(_recompensasAcumuladas.itensColetados);

    // Limpa as recompensas acumuladas
    _recompensasAcumuladas.limpar();

    return resultado;
  }

  /// Retorna as recompensas acumuladas atuais
  static RecompensasAcumuladas get recompensasAtuais => _recompensasAcumuladas;

  /// Escolhe um item aleatório da lista de itens possíveis
  static Item? _escolherItemAleatorio(List<String> nomesItens) {
    if (nomesItens.isEmpty) return null;

    final nomeEscolhido = nomesItens[_random.nextInt(nomesItens.length)];

    // Procura o item na lista de itens disponíveis
    final itemEncontrado = itensDisponiveis.firstWhere(
      (item) => item.nome == nomeEscolhido,
      orElse: () =>
          Item(nome: nomeEscolhido, descricao: 'Item encontrado em batalha.'),
    );

    return itemEncontrado;
  }
}
