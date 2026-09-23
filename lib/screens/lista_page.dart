import 'formulario_page.dart';
import 'package:flutter/material.dart';
import '../models/jogo.dart';
import '../widgets/estado_vazio.dart';
import '../widgets/jogo_card.dart';
import 'detalhe_page.dart';

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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetalhePage(
          jogo: jogo,
          onEditar: () {
            Navigator.of(context).pop();
            _abrirEdicao(jogo);
          },
        ),
      ),
    );
  }

   Future<void> _abrirFormulario() async {
    final resultado = await Navigator.of(context).push<Jogo>(
      MaterialPageRoute(
        builder: (_) => const FormularioPage(),
      ),
    );

    if (resultado != null) {
      setState(() {
        _jogos.add(resultado);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${resultado.titulo}" adicionado!')),
      );
    }
  }

  Future<void> _abrirEdicao(Jogo jogo) async {
    final resultado = await Navigator.of(context).push<Jogo>(
      MaterialPageRoute(
        builder: (_) => FormularioPage(jogo: jogo),
      ),
    );

    if (resultado != null) {
      setState(() {
        final index = _jogos.indexWhere((j) => j.id == resultado.id);
        if (index != -1) {
          _jogos[index] = resultado;
        }
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${resultado.titulo}" atualizado!')),
      );
    }
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
          : LayoutBuilder(
              builder: (context, constraints) {
                // Em telas largas (>= 600dp), usa 2 colunas.
                // Em telas estreitas, mantém 1 coluna.
                final bool telaLarga = constraints.maxWidth >= 600;

                if (telaLarga) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 116,
                    ),
                    itemCount: _jogos.length,
                    itemBuilder: (context, index) {
                      final jogo = _jogos[index];
                      return JogoCard(
                        jogo: jogo,
                        onTap: () => _abrirDetalhe(jogo),
                      );
                    },
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _jogos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final jogo = _jogos[index];
                    return JogoCard(
                      jogo: jogo,
                      onTap: () => _abrirDetalhe(jogo),
                    );
                  },
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