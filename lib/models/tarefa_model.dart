class Tarefa {
  final int? id;
  final String titulo;
  final String descricao;
  final String prioridade; // BAIXA, MÉDIA, ALTA
  final String criadoEm;
  final int flagSincronizado; // 0 = false, 1 = true

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.prioridade,
    required this.criadoEm,
    required this.flagSincronizado,
  });

  // Converter para Map para inserir no banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'prioridade': prioridade,
      'criadoEm': criadoEm,
      'flagSincronizado': flagSincronizado,
    };
  }

  // Criar Tarefa a partir do Map (banco de dados)
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      prioridade: map['prioridade'],
      criadoEm: map['criadoEm'],
      flagSincronizado: map['flagSincronizado'] ?? 0,
    );
  }

  // Converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'prioridade': prioridade,
      'criadoEm': criadoEm,
      'flagSincronizado': flagSincronizado == 1,
    };
  }

  // Criar cópia com campos atualizados
  Tarefa copyWith({
    int? id,
    String? titulo,
    String? descricao,
    String? prioridade,
    String? criadoEm,
    int? flagSincronizado,
  }) {
    return Tarefa(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      prioridade: prioridade ?? this.prioridade,
      criadoEm: criadoEm ?? this.criadoEm,
      flagSincronizado: flagSincronizado ?? this.flagSincronizado,
    );
  }
}