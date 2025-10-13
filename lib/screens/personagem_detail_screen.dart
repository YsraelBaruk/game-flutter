import 'dart:math';

import 'package:flutter/material.dart';
import '../models/personagem.dart';
import '../models/inimigo.dart';
import '../models/item.dart';
import '../data/inimigos_data.dart';
import '../data/itens_data.dart';
import '../services/game_service.dart';
import '../services/personagemService.dart';
import '../services/recompensasService.dart';
import '../widgets/status_bar.dart';

class PersonagemDetailScreen extends StatefulWidget {
  final Personagem personagem;

  const PersonagemDetailScreen({super.key, required this.personagem});

  @override
  State<PersonagemDetailScreen> createState() => _PersonagemDetailScreenState();
}

class _PersonagemDetailScreenState extends State<PersonagemDetailScreen> {
  Inimigo? inimigoAtual;
  int _inimigoMaxHp = 0;
  int _multiplicadorMagia = 1;

  void _curar(int valor) {
    setState(() {
      widget.personagem.hp = min(
        widget.personagem.maxHp,
        widget.personagem.hp + valor,
      );
    });
    gameService.adicionarAoHistorico(
      '${widget.personagem.nome} curou $valor de HP.',
    );
  }

  void _receberDano(int valor) {
    setState(() {
      widget.personagem.hp = max(0, widget.personagem.hp - valor);
    });
    gameService.adicionarAoHistorico(
      '${widget.personagem.nome} recebeu $valor de dano.',
    );
    if (widget.personagem.hp == 0) {
      _mostrarDialog('Você morreu!');
    }
  }

  void _gastarMana(int custo) {
    if (widget.personagem.mana >= custo) {
      setState(() {
        widget.personagem.mana -= custo;
      });
      gameService.adicionarAoHistorico(
        '${widget.personagem.nome} gastou $custo de mana.',
      );
    } else {
      _mostrarDialog('Mana insuficiente!');
    }
  }

  void _recuperarMana(int valor) {
    setState(() {
      widget.personagem.mana = min(
        widget.personagem.maxMana,
        widget.personagem.mana + valor,
      );
    });
    gameService.adicionarAoHistorico(
      '${widget.personagem.nome} recuperou $valor de mana.',
    );
  }

  void _adicionarItem(Item item) {
    setState(() {
      widget.personagem.itens.add(item);
    });
    gameService.adicionarAoHistorico(
      '${item.nome} foi adicionado ao inventário.',
    );
  }

  void _removerItem(int index) {
    final itemRemovido = widget.personagem.itens[index];
    setState(() {
      widget.personagem.itens.removeAt(index);
    });
    gameService.adicionarAoHistorico(
      '${itemRemovido.nome} foi removido do inventário.',
    );
  }

  void _ganharXp(int valor) {
    setState(() {
      widget.personagem.xp += valor;
      if (widget.personagem.xp >= widget.personagem.proximoNivelXp) {
        // Usa o novo algoritmo de level up
        final personagemAtualizado = PersonagemService.processarLevelUp(
          widget.personagem,
        );

        // Atualiza os valores do personagem
        widget.personagem.nivel = personagemAtualizado.nivel;
        widget.personagem.xp = personagemAtualizado.xp;
        widget.personagem.proximoNivelXp = personagemAtualizado.proximoNivelXp;
        widget.personagem.ataque = personagemAtualizado.ataque;
        widget.personagem.defesa = personagemAtualizado.defesa;
        widget.personagem.maxHp = personagemAtualizado.maxHp;
        widget.personagem.hp = personagemAtualizado.hp;
        widget.personagem.maxMana = personagemAtualizado.maxMana;
        widget.personagem.mana = personagemAtualizado.mana;

        _mostrarDialog(
          'Subiu de nível! Agora você está no nível ${widget.personagem.nivel}!',
        );
        gameService.adicionarAoHistorico(
          '${widget.personagem.nome} subiu para o nível ${widget.personagem.nivel}!',
        );
      }
    });
  }

  void _encontrarInimigo() {
    setState(() {
      // Usa o novo sistema para encontrar inimigo apropriado
      final inimigoEscolhido = RecompensasService.obterInimigoApropriado(
        inimigosDisponiveis,
        widget.personagem.nivel,
      );

      if (inimigoEscolhido != null) {
        inimigoAtual = inimigoEscolhido.copyWith(hp: inimigoEscolhido.maxHp);
        _inimigoMaxHp = inimigoEscolhido.maxHp;
      } else {
        // Fallback para inimigo aleatório se não encontrar apropriado
        final inimigoOriginal =
            inimigosDisponiveis[Random().nextInt(inimigosDisponiveis.length)];
        inimigoAtual = inimigoOriginal.copyWith(hp: inimigoOriginal.maxHp);
        _inimigoMaxHp = inimigoOriginal.maxHp;
      }
    });
    gameService.adicionarAoHistorico('Um ${inimigoAtual!.nome} apareceu!');
  }

  void _ataqueFisico() {
    if (inimigoAtual == null) return;

    if (widget.personagem.ataque > inimigoAtual!.defesa) {
      int dano = widget.personagem.ataque - inimigoAtual!.defesa;
      setState(() {
        inimigoAtual!.hp = max(0, inimigoAtual!.hp - dano);
      });
      _mostrarDialog('Acertou! Causou $dano de dano.');
      gameService.adicionarAoHistorico(
        '${widget.personagem.nome} causou $dano de dano físico em ${inimigoAtual!.nome}.',
      );
    } else {
      _mostrarDialog('Defendeu! O inimigo bloqueou o ataque.');
      gameService.adicionarAoHistorico(
        '${inimigoAtual!.nome} defendeu o ataque de ${widget.personagem.nome}.',
      );
    }
    _verificarFimBatalha();
  }

  void _ataqueMagico(MagiaTipo tipo, int custoMana) {
    if (inimigoAtual == null) return;
    if (widget.personagem.mana < custoMana) {
      _mostrarDialog('Mana insuficiente!');
      return;
    }

    _gastarMana(custoMana);
    int danoBase = 15;
    double multiplicadorFraqueza = (inimigoAtual!.fraqueza == tipo) ? 1.5 : 1.0;
    int danoFinal = (danoBase * _multiplicadorMagia * multiplicadorFraqueza)
        .round();

    setState(() {
      inimigoAtual!.hp = max(0, inimigoAtual!.hp - danoFinal);
    });

    String log = '${tipo.name} x$_multiplicadorMagia → $danoFinal de dano!';
    _mostrarDialog(log);
    gameService.adicionarAoHistorico(log);
    _verificarFimBatalha();
  }

  void _verificarFimBatalha() {
    if (inimigoAtual != null && inimigoAtual!.hp == 0) {
      // Processa recompensas do inimigo derrotado
      final recompensas = RecompensasService.processarRecompensas(
        inimigoAtual!,
      );

      // Aplica as recompensas
      RecompensasService.aplicarRecompensas(
        widget.personagem,
        recompensas,
        widget.personagem.inventario,
      );

      // Ganha XP baseado nas recompensas
      _ganharXp(recompensas['experiencia'] as int);

      // Mostra informações das recompensas
      final moedasGanhas = recompensas['moedas'] as int;
      final itensGanhos = recompensas['itens'] as List<Item>;

      String mensagemRecompensas = '${inimigoAtual!.nome} foi derrotado!\n';
      mensagemRecompensas +=
          'XP: +${recompensas['experiencia']} | Moedas: +$moedasGanhas';

      if (itensGanhos.isNotEmpty) {
        mensagemRecompensas +=
            '\nItens: ${itensGanhos.map((i) => i.nome).join(', ')}';
      }

      _mostrarDialog(mensagemRecompensas);
      gameService.adicionarAoHistorico('${inimigoAtual!.nome} foi derrotado.');

      setState(() {
        inimigoAtual = null;
      });
    }
  }

  void _mostrarDialog(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(widget.personagem.nome),
        backgroundColor: Colors.grey.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Status
            _buildCard(
              'Status',
              Column(
                children: [
                  StatusBar(
                    label: 'HP',
                    valorAtual: widget.personagem.hp,
                    valorMaximo: widget.personagem.maxHp,
                    corPositiva: Colors.green,
                    corNegativa: Colors.red,
                  ),
                  const SizedBox(height: 12),
                  StatusBar(
                    label: 'Mana',
                    valorAtual: widget.personagem.mana,
                    valorMaximo: widget.personagem.maxMana,
                    corPositiva: Colors.blue,
                    corNegativa: Colors.purple.shade900,
                  ),
                  const SizedBox(height: 12),
                  StatusBar(
                    label: 'XP',
                    valorAtual: widget.personagem.xp,
                    valorMaximo: widget.personagem.proximoNivelXp,
                    corPositiva: Colors.orange,
                    corMedia: Colors.orange.shade300,
                    corNegativa: Colors.orange.shade800,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nível: ${widget.personagem.nivel}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ataque: ${widget.personagem.ataque}/${PersonagemService.calcularLimiteMaximoAtaque(widget.personagem.nivel)}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    'Defesa: ${widget.personagem.defesa}/${PersonagemService.calcularLimiteMaximoDefesa(widget.personagem.nivel)}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Moedas: ${widget.personagem.inventario.moedas.quantidade}',
                    style: const TextStyle(color: Colors.yellow, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildProximoLevelUpInfo(),
                ],
              ),
            ),

            // Seção de Ações
            _buildCard(
              'Ações',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _curar(10),
                    icon: const Icon(Icons.favorite),
                    label: const Text('Curar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _receberDano(10),
                    icon: const Icon(Icons.warning),
                    label: const Text('Dano'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _recuperarMana(10),
                    icon: const Icon(Icons.battery_charging_full),
                    label: const Text('Rec. Mana'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _ganharXp(25),
                    icon: const Icon(Icons.star),
                    label: const Text('Ganhar XP'),
                  ),
                ],
              ),
            ),

            // Seção de Batalha
            _buildCard(
              'Batalha',
              inimigoAtual == null
                  ? Center(
                      child: ElevatedButton.icon(
                        onPressed: _encontrarInimigo,
                        icon: const Icon(Icons.search),
                        label: const Text('Encontrar Inimigo'),
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                          'Inimigo: ${inimigoAtual!.nome} (Nível ${inimigoAtual!.nivel})',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ataque: ${inimigoAtual!.ataque} | Defesa: ${inimigoAtual!.defesa}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildRecompensasInimigo(),
                        const SizedBox(height: 8),
                        StatusBar(
                          label: 'HP Inimigo',
                          valorAtual: inimigoAtual!.hp,
                          valorMaximo:
                              _inimigoMaxHp, // Usa o HP máximo baseado no inimigo
                          corPositiva: Colors.red,
                          corNegativa: Colors.red.shade900,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _ataqueFisico,
                              icon: const Icon(Icons.gavel),
                              label: const Text('Ataque Físico'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _ataqueMagico(MagiaTipo.fogo, 10),
                              icon: const Icon(Icons.local_fire_department),
                              label: const Text('Fogo'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _ataqueMagico(MagiaTipo.gelo, 10),
                              icon: const Icon(Icons.ac_unit),
                              label: const Text('Gelo'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Multiplicador Magia:',
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () => setState(
                                () => _multiplicadorMagia = max(
                                  1,
                                  _multiplicadorMagia - 1,
                                ),
                              ),
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$_multiplicadorMagia',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  setState(() => _multiplicadorMagia++),
                              icon: const Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),

            // Seção de Inventário
            _buildCard(
              'Inventário',
              Column(
                children: [
                  ...widget.personagem.itens.asMap().entries.map(
                    (entry) => ListTile(
                      leading: const Icon(Icons.shield, color: Colors.white),
                      title: Text(
                        entry.value.nome,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => _removerItem(entry.key),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => _adicionarItem(
                      itensDisponiveis[Random().nextInt(
                        itensDisponiveis.length,
                      )],
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Item Aleatório'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, Widget child) {
    return Card(
      color: Colors.grey.shade800,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.white54),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildProximoLevelUpInfo() {
    final infoProximoLevel = PersonagemService.obterInfoProximoLevelUp(
      widget.personagem,
    );
    final crescimento = infoProximoLevel['crescimento'] as Map<String, int>;
    final xpRestante = infoProximoLevel['xpRestante'] as int;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Próximo Level Up',
            style: TextStyle(
              color: Colors.blue.shade200,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'XP restante: $xpRestante',
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ataque: +${crescimento['ataque']}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              Text(
                'Defesa: +${crescimento['defesa']}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HP: +${crescimento['hp']}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              Text(
                'Mana: +${crescimento['mana']}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecompensasInimigo() {
    final infoRecompensas = RecompensasService.obterInfoRecompensas(
      inimigoAtual!,
    );

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.green.shade900,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        children: [
          Text(
            'Recompensas',
            style: TextStyle(
              color: Colors.green.shade200,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'XP: ${infoRecompensas['experiencia']}',
                style: const TextStyle(color: Colors.white, fontSize: 9),
              ),
              Text(
                'Moedas: ${infoRecompensas['moedas']}',
                style: const TextStyle(color: Colors.white, fontSize: 9),
              ),
            ],
          ),
          if (infoRecompensas['itensPossiveis'].isNotEmpty)
            Text(
              'Chance item: ${(infoRecompensas['chanceItem'] * 100).round()}%',
              style: const TextStyle(color: Colors.white70, fontSize: 8),
            ),
        ],
      ),
    );
  }
}
