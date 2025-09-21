import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final String label;
  final int valorAtual;
  final int valorMaximo;
  final Color corPositiva;
  final Color corMedia;
  final Color corNegativa;

  const StatusBar({
    super.key,
    required this.label,
    required this.valorAtual,
    required this.valorMaximo,
    required this.corPositiva,
    this.corMedia = Colors.yellow,
    required this.corNegativa,
  });

  Color _getCor() {
    double porcentagem = valorAtual / valorMaximo;
    if (porcentagem > 0.5) return corPositiva;
    if (porcentagem > 0.2) return corMedia;
    return corNegativa;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $valorAtual / $valorMaximo', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: valorAtual / valorMaximo,
          backgroundColor: Colors.grey.shade700,
          valueColor: AlwaysStoppedAnimation<Color>(_getCor()),
          minHeight: 12,
        ),
      ],
    );
  }
}
