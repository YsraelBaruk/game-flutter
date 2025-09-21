import 'package:flutter/material.dart';

class GameService extends ChangeNotifier {
  final List<String> _historico = [];

  List<String> get historico => _historico;

  void adicionarAoHistorico(String acao) {
    _historico.insert(0, acao);
    notifyListeners();
  }

  void limparHistorico() {
    _historico.clear();
    notifyListeners();
  }
}

// Global instance to be used across the app
final gameService = GameService();
