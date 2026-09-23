import 'package:flutter/material.dart';
import '../models/jogo.dart';

/// Tela de formulário usada tanto para CRIAR quanto para EDITAR um jogo.
/// Se `jogo` for null → modo criação (gera um novo id).
/// Se `jogo` for fornecido → modo edição (preserva o id original).
class FormularioPage extends StatefulWidget {
  final Jogo? jogo;

  const FormularioPage({super.key, this.jogo});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _tituloController;
  late final TextEditingController _plataformaController;
  late final TextEditingController _generoController;
  late final TextEditingController _anoController;
  late final TextEditingController _notaController;

  String _statusSelecionado = 'Na fila';

  static const List<String> _statusOpcoes = [
    'Na fila',
    'Jogando',
    'Zerado',
    'Abandonado',
  ];

  bool get _modoEdicao => widget.jogo != null;

  @override
  void initState() {
    super.initState();
    final jogo = widget.jogo;
    _tituloController = TextEditingController(text: jogo?.titulo ?? '');
    _plataformaController =
        TextEditingController(text: jogo?.plataforma ?? '');
    _generoController = TextEditingController(text: jogo?.genero ?? '');
    _anoController =
        TextEditingController(text: jogo?.ano.toString() ?? '');
    _notaController = TextEditingController(
      text: jogo != null ? jogo.nota.toString() : '',
    );
    _statusSelecionado = jogo?.status ?? 'Na fila';
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _plataformaController.dispose();
    _generoController.dispose();
    _anoController.dispose();
    _notaController.dispose();
    super.dispose();
  }

  // ---------- Validações ----------

  String? _validarTitulo(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) {
      return 'Informe o título do jogo';
    }
    if (texto.length < 2) {
      return 'O título precisa ter pelo menos 2 caracteres';
    }
    return null;
  }

  String? _validarPlataforma(String? valor) {
    if ((valor ?? '').trim().isEmpty) {
      return 'Informe a plataforma';
    }
    return null;
  }

  String? _validarGenero(String? valor) {
    if ((valor ?? '').trim().isEmpty) {
      return 'Informe o gênero';
    }
    return null;
  }

  String? _validarAno(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) {
      return 'Informe o ano';
    }
    final ano = int.tryParse(texto);
    if (ano == null) {
      return 'Use apenas números';
    }
    if (ano < 1950 || ano > 2100) {
      return 'Ano deve estar entre 1950 e 2100';
    }
    return null;
  }

  String? _validarNota(String? valor) {
    final texto = valor?.trim().replaceAll(',', '.') ?? '';
    if (texto.isEmpty) {
      return 'Informe a nota';
    }
    final nota = double.tryParse(texto);
    if (nota == null) {
      return 'Use um número (ex.: 9.5)';
    }
    if (nota < 0 || nota > 10) {
      return 'Nota deve estar entre 0 e 10';
    }
    return null;
  }

  // ---------- Ações ----------

  void _salvar() {
    if (!_formKey.currentState!.validate()) {
      // Rolagem automática até o primeiro erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Corrija os campos destacados antes de salvar.'),
        ),
      );
      return;
    }

    final titulo = _tituloController.text.trim();
    final plataforma = _plataformaController.text.trim();
    final genero = _generoController.text.trim();
    final ano = int.parse(_anoController.text.trim());
    final nota = double.parse(
      _notaController.text.trim().replaceAll(',', '.'),
    );

    final resultado = _modoEdicao
        ? widget.jogo!.copyWith(
            titulo: titulo,
            plataforma: plataforma,
            genero: genero,
            ano: ano,
            nota: nota,
            status: _statusSelecionado,
          )
        : Jogo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            titulo: titulo,
            plataforma: plataforma,
            genero: genero,
            ano: ano,
            nota: nota,
            status: _statusSelecionado,
          );

    Navigator.of(context).pop(resultado);
  }

  void _cancelar() {
    Navigator.of(context).pop();
  }

  // ---------- UI ----------

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_modoEdicao ? 'Editar jogo' : 'Novo jogo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancelar',
            onPressed: _cancelar,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título *',
                  hintText: 'Ex.: The Legend of Zelda',
                  prefixIcon: Icon(Icons.title),
                ),
                textInputAction: TextInputAction.next,
                validator: _validarTitulo,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _plataformaController,
                decoration: const InputDecoration(
                  labelText: 'Plataforma *',
                  hintText: 'Ex.: Nintendo Switch',
                  prefixIcon: Icon(Icons.devices),
                ),
                textInputAction: TextInputAction.next,
                validator: _validarPlataforma,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _generoController,
                decoration: const InputDecoration(
                  labelText: 'Gênero *',
                  hintText: 'Ex.: RPG, Ação, Aventura',
                  prefixIcon: Icon(Icons.category),
                ),
                textInputAction: TextInputAction.next,
                validator: _validarGenero,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _anoController,
                decoration: const InputDecoration(
                  labelText: 'Ano *',
                  hintText: 'Ex.: 2024',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: _validarAno,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _notaController,
                decoration: const InputDecoration(
                  labelText: 'Nota (0 a 10) *',
                  hintText: 'Ex.: 9.5',
                  prefixIcon: Icon(Icons.star),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                validator: _validarNota,
                onFieldSubmitted: (_) => _salvar(),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _statusSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: _statusOpcoes
                    .map(
                      (s) => DropdownMenuItem(value: s, child: Text(s)),
                    )
                    .toList(),
                onChanged: (valor) {
                  if (valor != null) {
                    setState(() => _statusSelecionado = valor);
                  }
                },
              ),
              const SizedBox(height: 32),

              FilledButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.check),
                label: Text(_modoEdicao ? 'Salvar alterações' : 'Adicionar'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _cancelar,
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}