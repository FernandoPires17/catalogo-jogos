import 'package:flutter/material.dart';
import '../models/jogo.dart';
import '../widgets/estado_vazio.dart';
import '../widgets/jogo_card.dart';

/// Tela principal: mostra a coleção de jogos.
/// Estado da coleção fica aqui (em memória) durante o M1.
class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final List<Jogo> _jogos = [
    const Jogo(
      id: '1',
      titulo: 'The Legend of Zelda: Majoras Mask',
      plataforma: 'Nintendo 64',
      genero: 'Aventura',
      ano: 2000,
      nota: 10.0,
      status: 'Zerado',
    ),
    const Jogo(
      id: '2',
      titulo: 'A Plague Tale: Requiem',
      plataforma: 'Xbox Series X',
      genero: 'Ação-aventura / Furtividade',
      ano: 2022,
      nota: 10.0,
      status: 'Zerado',
    ),
    const Jogo(
      id: '3',
      titulo: 'God of War Ragnarök',
      plataforma: 'PlayStation 5',
      genero: 'Ação',
      ano: 2022,
      nota: 9.0,
      status: 'Jogando',
    ),
    const Jogo(
      id: '4',
      titulo: 'Control Resonant',
      plataforma: 'PC',
      genero: 'Ação / Hack and Slash',
      ano: 2026,
      nota: 0.0,
      status: 'Na fila',
    ),
  ];

  void _abrirDetalhe(Jogo jogo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Abrir detalhes: ${jogo.titulo}')),
    );
  }

  void _abrirFormulario() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir formulário (em breve)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Jogos'),
      ),
      body: _jogos.isEmpty
          ? EstadoVazio(
              mensagem:
                  'Adicione seu primeiro jogo para começar a montar sua coleção.',
              textoBotao: 'Adicionar jogo',
              onAcao: _abrirFormulario,
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _jogos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final jogo = _jogos[index];
                return JogoCard(
                  jogo: jogo,
                  onTap: () => _abrirDetalhe(jogo),
                );
              },
            ),
      floatingActionButton: _jogos.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: _abrirFormulario,
              tooltip: 'Adicionar jogo',
              child: const Icon(Icons.add),
            ),
    );
  }
}