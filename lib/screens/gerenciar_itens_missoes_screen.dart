import 'package:flutter/material.dart';
import '../models/personagem.dart';
import '../models/item.dart';
import '../models/missao.dart';
import '../services/itemService.dart';
import '../services/missaoService.dart';
import '../data/itens_data.dart';

class GerenciarItensMissoesScreen extends StatefulWidget {
  final Personagem personagem;

  const GerenciarItensMissoesScreen({super.key, required this.personagem});

  @override
  State<GerenciarItensMissoesScreen> createState() =>
      _GerenciarItensMissoesScreenState();
}

class _GerenciarItensMissoesScreenState
    extends State<GerenciarItensMissoesScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    MissaoService.inicializarMissoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Itens e Missões'),
        backgroundColor: Colors.grey.shade800,
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.grey.shade800,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSidebarItem(0, 'Itens', Icons.inventory),
                _buildSidebarItem(1, 'Missões', Icons.assignment),
                _buildSidebarItem(2, 'Loja', Icons.store),
              ],
            ),
          ),
          // Conteúdo principal
          Expanded(child: _getCurrentContent()),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, String title, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: _selectedIndex == index ? Colors.blue : Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.blue : Colors.white,
            fontWeight: _selectedIndex == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        onTap: () => setState(() => _selectedIndex = index),
        tileColor: _selectedIndex == index ? Colors.blue.shade900 : null,
      ),
    );
  }

  Widget _getCurrentContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildItensContent();
      case 1:
        return _buildMissoesContent();
      case 2:
        return _buildLojaContent();
      default:
        return const Center(child: Text('Conteúdo não encontrado'));
    }
  }

  Widget _buildItensContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inventário de ${widget.personagem.nome}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.personagem.itens.length,
              itemBuilder: (context, index) {
                final item = widget.personagem.itens[index];
                return _buildItemCard(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Item item, int index) {
    final info = ItemService.obterInfoItem(item);

    return Card(
      color: Colors.grey.shade800,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (item.podeUsarEmBatalha)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'USÁVEL EM BATALHA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(item.descricao, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Tipo: ${info['tipo']}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(width: 16),
                Text(
                  'Quantidade: ${info['quantidade']}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            if (info['efeito'] != null) ...[
              const SizedBox(height: 4),
              Text(
                'Efeito: ${info['efeito']} (+${info['valorEfeito']})',
                style: const TextStyle(color: Colors.yellow),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Compra: ${info['precoCompra']} | Venda: ${info['precoVenda']}',
                  style: const TextStyle(color: Colors.green),
                ),
                Row(
                  children: [
                    if (item.podeUsarEmBatalha)
                      ElevatedButton.icon(
                        onPressed: () => _usarItem(item, index),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Usar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _venderItem(item, index),
                      icon: const Icon(Icons.sell),
                      label: const Text('Vender'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissoesContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Missões de ${widget.personagem.nome}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildEstatisticasMissoes(),
          const SizedBox(height: 16),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Ativas'),
                      Tab(text: 'Disponíveis'),
                      Tab(text: 'Concluídas'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildMissoesAtivas(),
                        _buildMissoesDisponiveis(),
                        _buildMissoesConcluidas(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstatisticasMissoes() {
    final stats = MissaoService.obterEstatisticasMissoes();

    return Card(
      color: Colors.grey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Total', stats['total'].toString(), Colors.white),
            _buildStatItem(
              'Concluídas',
              stats['concluidas'].toString(),
              Colors.green,
            ),
            _buildStatItem('Ativas', stats['ativas'].toString(), Colors.blue),
            _buildStatItem(
              'Disponíveis',
              stats['disponiveis'].toString(),
              Colors.orange,
            ),
            _buildStatItem(
              'Progresso',
              '${stats['porcentagemConcluidas']}%',
              Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMissoesAtivas() {
    final missoesAtivas = MissaoService.missoesAtivas;

    if (missoesAtivas.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma missão ativa',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      itemCount: missoesAtivas.length,
      itemBuilder: (context, index) {
        final missao = missoesAtivas[index];
        return _buildMissaoCard(missao, true);
      },
    );
  }

  Widget _buildMissoesDisponiveis() {
    final missoesDisponiveis = MissaoService.missoesDisponiveis;

    if (missoesDisponiveis.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma missão disponível',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      itemCount: missoesDisponiveis.length,
      itemBuilder: (context, index) {
        final missao = missoesDisponiveis[index];
        return _buildMissaoCard(missao, false);
      },
    );
  }

  Widget _buildMissoesConcluidas() {
    final missoesConcluidas = MissaoService.missoesConcluidas;

    if (missoesConcluidas.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma missão concluída',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      itemCount: missoesConcluidas.length,
      itemBuilder: (context, index) {
        final missao = missoesConcluidas[index];
        return _buildMissaoCard(missao, false);
      },
    );
  }

  Widget _buildMissaoCard(Missao missao, bool podeIniciar) {
    final progresso = MissaoService.obterProgressoMissao(missao);

    return Card(
      color: Colors.grey.shade800,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  missao.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(missao.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    missao.status.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              missao.descricao,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progresso['progressoGeral'] as double,
              backgroundColor: Colors.grey.shade600,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getStatusColor(missao.status),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Progresso: ${(progresso['progressoGeral'] * 100).round()}%',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            ...missao.objetivos.map(
              (obj) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• ${_getObjetivoTexto(obj)}: ${obj.quantidadeAtual}/${obj.quantidadeNecessaria}',
                  style: TextStyle(
                    color: obj.concluido ? Colors.green : Colors.white70,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recompensas: XP: ${missao.recompensaXp} | Moedas: ${missao.recompensaMoedas}',
                  style: const TextStyle(color: Colors.yellow),
                ),
                if (podeIniciar && missao.status == StatusMissao.naoIniciada)
                  ElevatedButton.icon(
                    onPressed: () => _iniciarMissao(missao),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Iniciar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLojaContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Loja',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: itensDisponiveis.length,
              itemBuilder: (context, index) {
                final item = itensDisponiveis[index];
                return _buildLojaItemCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLojaItemCard(Item item) {
    final info = ItemService.obterInfoItem(item);

    return Card(
      color: Colors.grey.shade800,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(item.descricao, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Tipo: ${info['tipo']}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(width: 16),
                Text(
                  'Preço: ${info['precoCompra']} moedas',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            if (info['efeito'] != null) ...[
              const SizedBox(height: 4),
              Text(
                'Efeito: ${info['efeito']} (+${info['valorEfeito']})',
                style: const TextStyle(color: Colors.yellow),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _comprarItem(item),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Comprar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(StatusMissao status) {
    switch (status) {
      case StatusMissao.naoIniciada:
        return Colors.grey;
      case StatusMissao.emAndamento:
        return Colors.blue;
      case StatusMissao.concluida:
        return Colors.green;
    }
  }

  String _getObjetivoTexto(ObjetivoMissao obj) {
    switch (obj.tipo) {
      case TipoMissao.derrotarInimigos:
        return obj.inimigoEspecifico != null
            ? 'Derrotar ${obj.inimigoEspecifico}'
            : 'Derrotar inimigos';
      case TipoMissao.coletarItens:
        return obj.itemEspecifico != null
            ? 'Coletar ${obj.itemEspecifico}'
            : 'Coletar itens';
      case TipoMissao.ganharXp:
        return 'Ganhar XP';
      case TipoMissao.ganharMoedas:
        return 'Ganhar moedas';
      case TipoMissao.usarItens:
        return 'Usar itens';
      case TipoMissao.completarBatalhas:
        return 'Completar batalhas';
    }
  }

  void _usarItem(Item item, int index) {
    final resultado = ItemService.usarItem(item, widget.personagem);

    if (resultado['sucesso']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultado['mensagem']),
          backgroundColor: Colors.green,
        ),
      );

      // Remove o item se for consumível
      if (item.tipo == TipoItem.consumivel) {
        setState(() {
          widget.personagem.itens.removeAt(index);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultado['mensagem']),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _venderItem(Item item, int index) {
    if (ItemService.podeVender(item)) {
      final valorVenda = ItemService.calcularValorVenda(item);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmar Venda'),
          content: Text('Vender ${item.nome} por $valorVenda moedas?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.personagem.itens.removeAt(index);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${item.nome} vendido por $valorVenda moedas!',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Vender'),
            ),
          ],
        ),
      );
    }
  }

  void _iniciarMissao(Missao missao) {
    if (MissaoService.iniciarMissao(missao)) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Missão "${missao.nome}" iniciada!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _comprarItem(Item item) {
    if (ItemService.podeComprar(widget.personagem, item)) {
      setState(() {
        widget.personagem.itens.add(item);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${item.nome} comprado por ${item.precoCompra} moedas!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Moedas insuficientes!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
