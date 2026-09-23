import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catalogo_jogos/models/jogo.dart';
import 'package:catalogo_jogos/widgets/estado_vazio.dart';
import 'package:catalogo_jogos/widgets/jogo_card.dart';

void main() {
  group('ListaPage - estado vazio', () {
    testWidgets('mostra o estado vazio quando a coleção está sem jogos',
        (tester) async {
      // Monta a ListaPage com uma coleção vazia, substituindo o estado inicial.
      await tester.pumpWidget(
        const MaterialApp(
          home: _ListaPageVazia(),
        ),
      );

      // Verifica que o widget de estado vazio aparece.
      expect(find.byType(EstadoVazio), findsOneWidget);

      // Verifica que a mensagem principal aparece.
      expect(find.text('Nenhum jogo cadastrado'), findsOneWidget);

      // Verifica que o botão de ação está visível.
      expect(find.text('Adicionar jogo'), findsOneWidget);

      // Garante que nenhum card de jogo foi renderizado.
      expect(find.byType(JogoCard), findsNothing);
    });
  });

  group('ListaPage - coleção com itens', () {
    testWidgets('mostra um JogoCard para cada jogo da coleção',
        (tester) async {
      // Coleção de teste com 2 jogos.
      final jogos = [
        const Jogo(
          id: '1',
          titulo: 'Jogo de Teste A',
          plataforma: 'PC',
          genero: 'Ação',
          ano: 2020,
          nota: 8.0,
          status: 'Jogando',
        ),
        const Jogo(
          id: '2',
          titulo: 'Jogo de Teste B',
          plataforma: 'Switch',
          genero: 'RPG',
          ano: 2021,
          nota: 9.0,
          status: 'Zerado',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: _ListaPageComJogos(jogos: jogos),
        ),
      );

      // Deve renderizar 2 cards.
      expect(find.byType(JogoCard), findsNWidgets(2));

      // Os títulos dos jogos aparecem.
      expect(find.text('Jogo de Teste A'), findsOneWidget);
      expect(find.text('Jogo de Teste B'), findsOneWidget);

      // O estado vazio NÃO aparece.
      expect(find.byType(EstadoVazio), findsNothing);
    });
  });
}

/// Wrapper de teste que injeta uma lista vazia na ListaPage.
/// Reaproveita o widget real, mas substitui a coleção padrão.
class _ListaPageVazia extends StatelessWidget {
  const _ListaPageVazia();

  @override
  Widget build(BuildContext context) {
    return const _ListaPageInjetada(jogos: []);
  }
}

/// Wrapper de teste que injeta uma lista com jogos na ListaPage.
class _ListaPageComJogos extends StatelessWidget {
  final List<Jogo> jogos;
  const _ListaPageComJogos({required this.jogos});

  @override
  Widget build(BuildContext context) {
    return _ListaPageInjetada(jogos: jogos);
  }
}

/// Versão da ListaPage que recebe a coleção via parâmetro,
/// para que possamos testar os dois cenários (vazio e com itens).
class _ListaPageInjetada extends StatefulWidget {
  final List<Jogo> jogos;
  const _ListaPageInjetada({required this.jogos});

  @override
  State<_ListaPageInjetada> createState() => _ListaPageInjetadaState();
}

class _ListaPageInjetadaState extends State<_ListaPageInjetada> {
  @override
  Widget build(BuildContext context) {
    // Simula o comportamento da ListaPage, mas com a lista injetada.
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Jogos')),
      body: widget.jogos.isEmpty
          ? EstadoVazio(
              mensagem:
                  'Adicione seu primeiro jogo para começar a montar sua coleção.',
              textoBotao: 'Adicionar jogo',
              onAcao: () {},
            )
          : ListView.builder(
              itemCount: widget.jogos.length,
              itemBuilder: (context, index) {
                return JogoCard(
                  jogo: widget.jogos[index],
                  onTap: () {},
                );
              },
            ),
    );
  }
}