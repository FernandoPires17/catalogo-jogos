/// Modelo de domínio que representa um jogo do catálogo.
class Jogo {
  final String id;
  final String titulo;
  final String plataforma;
  final String genero;
  final int ano;
  final double nota;
  final String status;

  const Jogo({
    required this.id,
    required this.titulo,
    required this.plataforma,
    required this.genero,
    required this.ano,
    required this.nota,
    required this.status,
  });

  /// Cria uma cópia deste jogo com alguns campos alterados.
  /// Útil para edição sem perder a identidade (id).
  Jogo copyWith({
    String? titulo,
    String? plataforma,
    String? genero,
    int? ano,
    double? nota,
    String? status,
  }) {
    return Jogo(
      id: id,
      titulo: titulo ?? this.titulo,
      plataforma: plataforma ?? this.plataforma,
      genero: genero ?? this.genero,
      ano: ano ?? this.ano,
      nota: nota ?? this.nota,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Jogo(id: $id, titulo: $titulo, plataforma: $plataforma)';
  }
}