import '../models/personagem.dart';

class PersonagemService {
  // Configurações de limitação de atributos por nível
  static const int _baseAtaqueMaximo = 20;
  static const int _baseDefesaMaxima = 15;
  static const int _baseHpMaximo = 150;
  static const int _baseManaMaxima = 100;

  // Multiplicador por nível para crescimento dos limites
  static const double _multiplicadorPorNivel = 1.5;

  // Configurações de crescimento automático por nível
  static const int _crescimentoAtaquePorNivel = 2;
  static const int _crescimentoDefesaPorNivel = 1;
  static const int _crescimentoHpPorNivel = 10;
  static const int _crescimentoManaPorNivel = 5;

  /// Calcula o limite máximo de ataque baseado no nível do personagem
  static int calcularLimiteMaximoAtaque(int nivel) {
    return (_baseAtaqueMaximo + (nivel - 1) * _multiplicadorPorNivel).round();
  }

  /// Calcula o limite máximo de defesa baseado no nível do personagem
  static int calcularLimiteMaximoDefesa(int nivel) {
    return (_baseDefesaMaxima + (nivel - 1) * _multiplicadorPorNivel).round();
  }

  /// Calcula o limite máximo de HP baseado no nível do personagem
  static int calcularLimiteMaximoHp(int nivel) {
    return (_baseHpMaximo + (nivel - 1) * _multiplicadorPorNivel * 2).round();
  }

  /// Calcula o limite máximo de Mana baseado no nível do personagem
  static int calcularLimiteMaximoMana(int nivel) {
    return (_baseManaMaxima + (nivel - 1) * _multiplicadorPorNivel).round();
  }

  /// Aplica limitações de atributos baseadas no nível do personagem
  static Personagem aplicarLimitacoesDeNivel(Personagem personagem) {
    final limiteAtaque = calcularLimiteMaximoAtaque(personagem.nivel);
    final limiteDefesa = calcularLimiteMaximoDefesa(personagem.nivel);
    final limiteHp = calcularLimiteMaximoHp(personagem.nivel);
    final limiteMana = calcularLimiteMaximoMana(personagem.nivel);

    return Personagem(
      nome: personagem.nome,
      imagem: personagem.imagem,
      inventario: personagem.inventario,
      missao: personagem.missao,
      cidade: personagem.cidade,
      maxHp: personagem.maxHp > limiteHp ? limiteHp : personagem.maxHp,
      hp: personagem.hp > limiteHp ? limiteHp : personagem.hp,
      maxMana: personagem.maxMana > limiteMana
          ? limiteMana
          : personagem.maxMana,
      mana: personagem.mana > limiteMana ? limiteMana : personagem.mana,
      xp: personagem.xp,
      proximoNivelXp: personagem.proximoNivelXp,
      nivel: personagem.nivel,
      ataque: personagem.ataque > limiteAtaque
          ? limiteAtaque
          : personagem.ataque,
      defesa: personagem.defesa > limiteDefesa
          ? limiteDefesa
          : personagem.defesa,
    );
  }

  /// Verifica se um personagem pode aumentar um atributo específico
  static bool podeAumentarAtaque(Personagem personagem, int valorAdicional) {
    final limiteMaximo = calcularLimiteMaximoAtaque(personagem.nivel);
    return (personagem.ataque + valorAdicional) <= limiteMaximo;
  }

  /// Verifica se um personagem pode aumentar a defesa
  static bool podeAumentarDefesa(Personagem personagem, int valorAdicional) {
    final limiteMaximo = calcularLimiteMaximoDefesa(personagem.nivel);
    return (personagem.defesa + valorAdicional) <= limiteMaximo;
  }

  /// Verifica se um personagem pode aumentar o HP
  static bool podeAumentarHp(Personagem personagem, int valorAdicional) {
    final limiteMaximo = calcularLimiteMaximoHp(personagem.nivel);
    return (personagem.maxHp + valorAdicional) <= limiteMaximo;
  }

  /// Verifica se um personagem pode aumentar a Mana
  static bool podeAumentarMana(Personagem personagem, int valorAdicional) {
    final limiteMaximo = calcularLimiteMaximoMana(personagem.nivel);
    return (personagem.maxMana + valorAdicional) <= limiteMaximo;
  }

  /// Retorna informações sobre os limites atuais do personagem
  static Map<String, int> obterLimitesAtuais(Personagem personagem) {
    return {
      'ataqueMaximo': calcularLimiteMaximoAtaque(personagem.nivel),
      'defesaMaxima': calcularLimiteMaximoDefesa(personagem.nivel),
      'hpMaximo': calcularLimiteMaximoHp(personagem.nivel),
      'manaMaxima': calcularLimiteMaximoMana(personagem.nivel),
    };
  }

  /// Retorna informações sobre quanto cada atributo pode crescer
  static Map<String, int> obterCrescimentoDisponivel(Personagem personagem) {
    final limites = obterLimitesAtuais(personagem);
    return {
      'ataqueDisponivel': limites['ataqueMaximo']! - personagem.ataque,
      'defesaDisponivel': limites['defesaMaxima']! - personagem.defesa,
      'hpDisponivel': limites['hpMaximo']! - personagem.maxHp,
      'manaDisponivel': limites['manaMaxima']! - personagem.maxMana,
    };
  }

  /// Calcula o crescimento automático de atributos ao subir de nível
  static Map<String, int> calcularCrescimentoAutomatico(int nivelAtual) {
    return {
      'ataque': _crescimentoAtaquePorNivel,
      'defesa': _crescimentoDefesaPorNivel,
      'hp': _crescimentoHpPorNivel,
      'mana': _crescimentoManaPorNivel,
    };
  }

  /// Aplica o crescimento automático de atributos ao subir de nível
  static Personagem aplicarLevelUp(Personagem personagem) {
    final crescimento = calcularCrescimentoAutomatico(personagem.nivel);

    // Calcula os novos valores com crescimento automático
    int novoAtaque = personagem.ataque + crescimento['ataque']!;
    int novaDefesa = personagem.defesa + crescimento['defesa']!;
    int novoMaxHp = personagem.maxHp + crescimento['hp']!;
    int novoMaxMana = personagem.maxMana + crescimento['mana']!;

    // Aplica os limites máximos baseados no novo nível
    final limiteAtaque = calcularLimiteMaximoAtaque(personagem.nivel);
    final limiteDefesa = calcularLimiteMaximoDefesa(personagem.nivel);
    final limiteHp = calcularLimiteMaximoHp(personagem.nivel);
    final limiteMana = calcularLimiteMaximoMana(personagem.nivel);

    // Garante que os valores não excedam os limites
    novoAtaque = novoAtaque > limiteAtaque ? limiteAtaque : novoAtaque;
    novaDefesa = novaDefesa > limiteDefesa ? limiteDefesa : novaDefesa;
    novoMaxHp = novoMaxHp > limiteHp ? limiteHp : novoMaxHp;
    novoMaxMana = novoMaxMana > limiteMana ? limiteMana : novoMaxMana;

    // Mantém o HP atual proporcional ao novo máximo
    int novoHp = personagem.hp;
    if (novoMaxHp > personagem.maxHp) {
      // Calcula a porcentagem atual de HP e aplica ao novo máximo
      double porcentagemHp = personagem.hp / personagem.maxHp;
      novoHp = (novoMaxHp * porcentagemHp).round();
    }

    // Mantém a Mana atual proporcional ao novo máximo
    int novaMana = personagem.mana;
    if (novoMaxMana > personagem.maxMana) {
      // Calcula a porcentagem atual de Mana e aplica ao novo máximo
      double porcentagemMana = personagem.mana / personagem.maxMana;
      novaMana = (novoMaxMana * porcentagemMana).round();
    }

    return Personagem(
      nome: personagem.nome,
      imagem: personagem.imagem,
      inventario: personagem.inventario,
      missao: personagem.missao,
      cidade: personagem.cidade,
      maxHp: novoMaxHp,
      hp: novoHp,
      maxMana: novoMaxMana,
      mana: novaMana,
      xp: personagem.xp,
      proximoNivelXp: personagem.proximoNivelXp,
      nivel: personagem.nivel,
      ataque: novoAtaque,
      defesa: novaDefesa,
    );
  }

  /// Processa o level up completo: aumenta nível, aplica crescimento e limitações
  static Personagem processarLevelUp(Personagem personagem) {
    // Primeiro aumenta o nível
    personagem.nivel++;
    personagem.xp = 0;
    personagem.proximoNivelXp = (personagem.proximoNivelXp * 1.5).round();

    // Depois aplica o crescimento automático
    return aplicarLevelUp(personagem);
  }

  /// Retorna informações sobre o próximo level up
  static Map<String, dynamic> obterInfoProximoLevelUp(Personagem personagem) {
    final crescimento = calcularCrescimentoAutomatico(personagem.nivel + 1);
    final limitesAtuais = obterLimitesAtuais(personagem);
    final limitesProximos = {
      'ataqueMaximo': calcularLimiteMaximoAtaque(personagem.nivel + 1),
      'defesaMaxima': calcularLimiteMaximoDefesa(personagem.nivel + 1),
      'hpMaximo': calcularLimiteMaximoHp(personagem.nivel + 1),
      'manaMaxima': calcularLimiteMaximoMana(personagem.nivel + 1),
    };

    return {
      'crescimento': crescimento,
      'limitesAtuais': limitesAtuais,
      'limitesProximos': limitesProximos,
      'xpRestante': personagem.proximoNivelXp - personagem.xp,
    };
  }
}
