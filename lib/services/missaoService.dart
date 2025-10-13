import '../models/missao.dart';
import '../models/personagem.dart';

class MissaoService {
  static final List<Missao> _missoesDisponiveis = [];
  static final List<Missao> _missoesAtivas = [];

  /// Inicializa as missões disponíveis
  static void inicializarMissoes() {
    _missoesDisponiveis.clear();
    _missoesAtivas.clear();

    // Missão 1: Derrotar Goblin
    _missoesDisponiveis.add(
      Missao(
        nome: 'Primeira Caça',
        descricao: 'Derrote 3 Goblins para provar sua coragem.',
        objetivos: [
          ObjetivoMissao(
            tipo: TipoMissao.derrotarInimigos,
            quantidadeNecessaria: 3,
            inimigoEspecifico: 'Goblin',
          ),
        ],
        recompensaXp: 50,
        recompensaMoedas: 25,
        recompensaItens: ['Poção Pequena'],
      ),
    );

    // Missão 2: Coletar Itens
    _missoesDisponiveis.add(
      Missao(
        nome: 'Colecionador',
        descricao: 'Colete 5 itens diferentes para expandir seu inventário.',
        objetivos: [
          ObjetivoMissao(
            tipo: TipoMissao.coletarItens,
            quantidadeNecessaria: 5,
          ),
        ],
        recompensaXp: 75,
        recompensaMoedas: 50,
        recompensaItens: ['Poção de Vida'],
      ),
    );

    // Missão 3: Ganhar XP
    _missoesDisponiveis.add(
      Missao(
        nome: 'Experiência em Batalha',
        descricao: 'Ganhe 100 XP através de batalhas.',
        objetivos: [
          ObjetivoMissao(tipo: TipoMissao.ganharXp, quantidadeNecessaria: 100),
        ],
        recompensaXp: 100,
        recompensaMoedas: 75,
        recompensaItens: ['Espada de Ferro'],
      ),
    );

    // Missão 4: Usar Itens
    _missoesDisponiveis.add(
      Missao(
        nome: 'Usuário de Itens',
        descricao: 'Use 3 itens durante batalhas.',
        objetivos: [
          ObjetivoMissao(tipo: TipoMissao.usarItens, quantidadeNecessaria: 3),
        ],
        recompensaXp: 60,
        recompensaMoedas: 40,
        recompensaItens: ['Poção de Mana'],
      ),
    );

    // Missão 5: Completa
    _missoesDisponiveis.add(
      Missao(
        nome: 'Guerreiro Experiente',
        descricao: 'Complete 5 batalhas e derrote 2 Esqueletos.',
        objetivos: [
          ObjetivoMissao(
            tipo: TipoMissao.completarBatalhas,
            quantidadeNecessaria: 5,
          ),
          ObjetivoMissao(
            tipo: TipoMissao.derrotarInimigos,
            quantidadeNecessaria: 2,
            inimigoEspecifico: 'Esqueleto',
          ),
        ],
        recompensaXp: 150,
        recompensaMoedas: 100,
        recompensaItens: ['Armadura de Couro', 'Escudo de Madeira'],
      ),
    );
  }

  /// Retorna missões disponíveis para iniciar
  static List<Missao> get missoesDisponiveis => _missoesDisponiveis
      .where((m) => m.status == StatusMissao.naoIniciada)
      .toList();

  /// Retorna missões ativas (em andamento)
  static List<Missao> get missoesAtivas => _missoesAtivas
      .where((m) => m.status == StatusMissao.emAndamento)
      .toList();

  /// Retorna missões concluídas
  static List<Missao> get missoesConcluidas => _missoesDisponiveis
      .where((m) => m.status == StatusMissao.concluida)
      .toList();

  /// Inicia uma missão
  static bool iniciarMissao(Missao missao) {
    if (missao.status == StatusMissao.naoIniciada) {
      missao.iniciar();
      _missoesAtivas.add(missao);
      return true;
    }
    return false;
  }

  /// Atualiza progresso de todas as missões ativas
  static void atualizarProgressoMissoes(
    TipoMissao tipo, {
    String? itemEspecifico,
    String? inimigoEspecifico,
    int quantidade = 1,
  }) {
    for (final missao in _missoesAtivas) {
      missao.atualizarProgresso(
        tipo,
        itemEspecifico: itemEspecifico,
        inimigoEspecifico: inimigoEspecifico,
        quantidade: quantidade,
      );
    }
  }

  /// Retorna estatísticas gerais das missões
  static Map<String, dynamic> obterEstatisticasMissoes() {
    final total = _missoesDisponiveis.length;
    final concluidas = missoesConcluidas.length;
    final ativas = _missoesAtivas.length;
    final disponiveis = missoesDisponiveis.length;

    return {
      'total': total,
      'concluidas': concluidas,
      'ativas': ativas,
      'disponiveis': disponiveis,
      'porcentagemConcluidas': total > 0
          ? (concluidas / total * 100).round()
          : 0,
    };
  }

  /// Retorna progresso detalhado de uma missão
  static Map<String, dynamic> obterProgressoMissao(Missao missao) {
    return {
      'nome': missao.nome,
      'descricao': missao.descricao,
      'status': missao.status.name,
      'progressoGeral': missao.progressoGeral,
      'objetivos': missao.objetivos
          .map(
            (obj) => {
              'tipo': obj.tipo.name,
              'quantidadeAtual': obj.quantidadeAtual,
              'quantidadeNecessaria': obj.quantidadeNecessaria,
              'progresso': obj.progresso,
              'concluido': obj.concluido,
              'itemEspecifico': obj.itemEspecifico,
              'inimigoEspecifico': obj.inimigoEspecifico,
            },
          )
          .toList(),
      'recompensas': {
        'xp': missao.recompensaXp,
        'moedas': missao.recompensaMoedas,
        'itens': missao.recompensaItens,
      },
    };
  }

  /// Aplica recompensas de uma missão concluída
  static Map<String, dynamic> aplicarRecompensasMissao(
    Missao missao,
    Personagem personagem,
  ) {
    final resultado = <String, dynamic>{
      'xpGanho': 0,
      'moedasGanhas': 0,
      'itensRecebidos': <String>[],
    };

    if (missao.status == StatusMissao.concluida) {
      // Aplica XP
      personagem.xp += missao.recompensaXp;
      resultado['xpGanho'] = missao.recompensaXp;

      // Aplica moedas (assumindo que o personagem tem sistema de moedas)
      // personagem.moedas += missao.recompensaMoedas;
      resultado['moedasGanhas'] = missao.recompensaMoedas;

      // Adiciona itens (simplificado - apenas adiciona à lista)
      resultado['itensRecebidos'] = List<String>.from(missao.recompensaItens);
    }

    return resultado;
  }
}
