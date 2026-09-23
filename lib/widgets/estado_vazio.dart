import 'package:flutter/material.dart';

/// Widget exibido quando a coleção está vazia.
/// Extraído para reutilização e para manter a ListaPage mais enxuta.
class EstadoVazio extends StatelessWidget {
  final String mensagem;
  final String textoBotao;
  final VoidCallback onAcao;

  const EstadoVazio({
    super.key,
    required this.mensagem,
    required this.textoBotao,
    required this.onAcao,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: 'Estado vazio. $mensagem',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videogame_asset_off_outlined,
                size: 96,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'Nenhum jogo cadastrado',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                mensagem,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onAcao,
                icon: const Icon(Icons.add),
                label: Text(textoBotao),
              ),
            ],
          ),
        ),
      ),
    );
  }
}