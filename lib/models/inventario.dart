import 'item.dart';

class Moedas {
  int quantidade;

  Moedas({this.quantidade = 0});

  void adicionar(int valor) {
    quantidade += valor;
  }

  bool gastar(int valor) {
    if (quantidade >= valor) {
      quantidade -= valor;
      return true;
    }
    return false;
  }

  bool podeGastar(int valor) {
    return quantidade >= valor;
  }
}

class Inventario {
  final List<Item> itens;
  final Moedas moedas;

  Inventario({List<Item>? itens, Moedas? moedas})
    : itens = itens ?? [],
      moedas = moedas ?? Moedas();

  void adicionarItem(Item item) {
    // Verifica se já existe um item igual para aumentar quantidade
    final indexExistente = itens.indexWhere(
      (i) => i.nome == item.nome && i.tipo == item.tipo,
    );

    if (indexExistente != -1 && item.tipo == TipoItem.consumivel) {
      // Para itens consumíveis, aumenta a quantidade
      itens[indexExistente] = itens[indexExistente].copyWith(
        quantidade: itens[indexExistente].quantidade! + item.quantidade!,
      );
    } else {
      // Para outros itens, adiciona como novo item
      itens.add(item);
    }
  }

  void removerItem(int index) {
    if (index >= 0 && index < itens.length) {
      itens.removeAt(index);
    }
  }

  void usarItem(int index) {
    if (index >= 0 && index < itens.length) {
      final item = itens[index];
      if (item.tipo == TipoItem.consumivel && item.quantidade! > 1) {
        // Diminui quantidade se for consumível
        itens[index] = item.copyWith(quantidade: item.quantidade! - 1);
      } else {
        // Remove completamente se quantidade for 1 ou não for consumível
        itens.removeAt(index);
      }
    }
  }

  List<Item> getItensPorTipo(TipoItem tipo) {
    return itens.where((item) => item.tipo == tipo).toList();
  }
}
