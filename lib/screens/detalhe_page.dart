import 'package:flutter/material.dart';
import '../models/jogo.dart';

/// Tela de detalhe: mostra todas as informações de um jogo.
/// Recebe o objeto Jogo selecionado na lista.
class DetalhePage extends StatelessWidget {
  final Jogo jogo;
  final VoidCallback? onEditar;

  const DetalhePage({
    super.key,
    required this.jogo,
    this.onEditar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(jogo.titulo),
        actions: [
          if (onEditar != null)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Editar jogo',
              onPressed: onEditar,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com ícone grande
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.videogame_asset,
                  size: 64,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Título
            Text(
              jogo.titulo,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            // Chip de status
            Chip(
              avatar: const Icon(Icons.flag, size: 18),
              label: Text(jogo.status),
              backgroundColor: theme.colorScheme.secondaryContainer,
            ),
            const SizedBox(height: 24),

            // Linha divisória
            const Divider(),
            const SizedBox(height: 16),

            // Informações em cards
            _InfoTile(
              icon: Icons.devices,
              label: 'Plataforma',
              valor: jogo.plataforma,
            ),
            _InfoTile(
              icon: Icons.category,
              label: 'Gênero',
              valor: jogo.genero,
            ),
            _InfoTile(
              icon: Icons.calendar_today,
              label: 'Ano',
              valor: jogo.ano.toString(),
            ),
            _InfoTile(
              icon: Icons.star,
              label: 'Nota',
              valor: jogo.nota.toStringAsFixed(1),
            ),
          ],
        ),
      ),
    );
  }
}

/// Linha reutilizável com ícone, rótulo e valor.
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valor;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  valor,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}