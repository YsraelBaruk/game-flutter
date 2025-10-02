import 'package:flutter/foundation.dart';
import 'item.dart';

class PlayerState extends ChangeNotifier {
  int _vidas = 3;
  int _moedas = 100;
  List<Item> _inventario = [];
  List<String> _missoesConcluidas = [];

  int get vidas => _vidas;
  int get moedas => _moedas;
  List<Item> get inventario => _inventario;
  List<String> get missoesConcluidas => _missoesConcluidas;

  void usarItem(Item item) {
    if (_inventario.contains(item)) {
      // Lógica de uso do item, por exemplo, recuperar vida
      if (item.nome == 'Poção de Vida') {
        _vidas = (_vidas + 1).clamp(0, 5); // Ex: Clamp para um máximo de 5 vidas
      }
      _inventario.remove(item);
      notifyListeners();
    }
  }

  void adicionarMoedas(int quantidade) {
    _moedas += quantidade;
    notifyListeners();
  }

  bool comprarItem(Item item) {
    if (_moedas >= item.preco) {
      _moedas = (_moedas - item.preco).toInt();
      _inventario.add(item);
      notifyListeners();
      return true;
    }
    return false;
  }

  void sofrerDano(int dano) {
    _vidas -= dano;
    if (_vidas < 0) {
      _vidas = 0;
    }
    notifyListeners();
  }

  void concluirMissao(String missaoId) {
    if (!_missoesConcluidas.contains(missaoId)) {
      _missoesConcluidas.add(missaoId);
      // Adicionar recompensa pela missão, se houver
      adicionarMoedas(50); // Ex: Recompensa de 50 moedas
      notifyListeners();
    }
  }

  bool get jogoGanho {
    // Exemplo de condição de vitória: concluir 3 missões
    return _missoesConcluidas.length >= 3;
  }

  bool get jogoPerdido {
    // Condição de derrota: vidas chegam a zero
    return _vidas <= 0;
  }
}