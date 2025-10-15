class Missao {
  final String id;
  final String descricao;
  final int objetivoTotal; // total necessário para concluir
  int progressoAtual; // progresso acumulado

  Missao({
    required this.id,
    required this.descricao,
    this.objetivoTotal = 1,
    this.progressoAtual = 0,
  });

  bool get concluida => progressoAtual >= objetivoTotal;
  double get progressoPercent => objetivoTotal == 0 ? 1.0 : (progressoAtual / objetivoTotal).clamp(0.0, 1.0);

  void adicionarProgresso([int valor = 1]) {
    progressoAtual = (progressoAtual + valor).clamp(0, objetivoTotal);
  }
}