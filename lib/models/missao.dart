enum TipoMissao {
  derrotarInimigos,
  coletarItens,
  ganharXp,
  ganharMoedas,
  usarItens,
  completarBatalhas,
}

enum StatusMissao { naoIniciada, emAndamento, concluida }

class ObjetivoMissao {
  final TipoMissao tipo;
  final int quantidadeNecessaria;
  final String? itemEspecifico;
  final String? inimigoEspecifico;
  int quantidadeAtual;

  ObjetivoMissao({
    required this.tipo,
    required this.quantidadeNecessaria,
    this.itemEspecifico,
    this.inimigoEspecifico,
    this.quantidadeAtual = 0,
  });

  bool get concluido => quantidadeAtual >= quantidadeNecessaria;

  double get progresso =>
      quantidadeNecessaria > 0 ? quantidadeAtual / quantidadeNecessaria : 0.0;
}

class Missao {
  final String nome;
  final String descricao;
  final List<ObjetivoMissao> objetivos;
  final int recompensaXp;
  final int recompensaMoedas;
  final List<String> recompensaItens;
  StatusMissao status;
  DateTime? dataInicio;
  DateTime? dataConclusao;

  Missao({
    required this.nome,
    required this.descricao,
    required this.objetivos,
    this.recompensaXp = 0,
    this.recompensaMoedas = 0,
    this.recompensaItens = const [],
    this.status = StatusMissao.naoIniciada,
    this.dataInicio,
    this.dataConclusao,
  });

  bool get concluida => objetivos.every((obj) => obj.concluido);

  double get progressoGeral {
    if (objetivos.isEmpty) return 0.0;
    final progressoTotal = objetivos.fold<double>(
      0.0,
      (sum, obj) => sum + obj.progresso,
    );
    return progressoTotal / objetivos.length;
  }

  void iniciar() {
    if (status == StatusMissao.naoIniciada) {
      status = StatusMissao.emAndamento;
      dataInicio = DateTime.now();
    }
  }

  void concluir() {
    if (concluida && status == StatusMissao.emAndamento) {
      status = StatusMissao.concluida;
      dataConclusao = DateTime.now();
    }
  }

  void atualizarProgresso(
    TipoMissao tipo, {
    String? itemEspecifico,
    String? inimigoEspecifico,
    int quantidade = 1,
  }) {
    if (status != StatusMissao.emAndamento) return;

    for (final objetivo in objetivos) {
      if (objetivo.tipo == tipo) {
        // Verifica se é o item/inimigo específico se especificado
        if (itemEspecifico != null && objetivo.itemEspecifico != null) {
          if (objetivo.itemEspecifico == itemEspecifico) {
            objetivo.quantidadeAtual += quantidade;
          }
        } else if (inimigoEspecifico != null &&
            objetivo.inimigoEspecifico != null) {
          if (objetivo.inimigoEspecifico == inimigoEspecifico) {
            objetivo.quantidadeAtual += quantidade;
          }
        } else if (objetivo.itemEspecifico == null &&
            objetivo.inimigoEspecifico == null) {
          objetivo.quantidadeAtual += quantidade;
        }
      }
    }

    // Verifica se a missão foi concluída
    if (concluida) {
      concluir();
    }
  }
}
