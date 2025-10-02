import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onTap(0),
                icon: const Icon(Icons.person),
                label: const Text('Personagens'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentIndex == 0 ? Colors.blue : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onTap(1),
                icon: const Icon(Icons.shopping_bag),
                label: const Text('Itens'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentIndex == 1 ? Colors.blue : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onTap(2),
                icon: const Icon(Icons.flag),
                label: const Text('Missões'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentIndex == 2 ? Colors.blue : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onTap(3),
                icon: const Icon(Icons.location_city),
                label: const Text('Cidades'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentIndex == 3 ? Colors.blue : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}