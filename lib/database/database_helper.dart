import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import '../models/tarefa_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // RA do aluno: 202310149
  static const String _dbName = 'RA_202310149_tarefas.db';
  static const String _tableName = 'tarefas';
  static const int _dbVersion = 1;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDatabase,
    );
  }

  /// Cria a estrutura do banco de dados
  /// COMMIT 2: Criação do banco SQLite
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT,
        prioridade TEXT NOT NULL,
        criadoEm TEXT NOT NULL,
        flagSincronizado INTEGER DEFAULT 0
      )
    ''');
    print('✅ Banco de dados criado com sucesso em: ${db.path}');
  }

  // ==================== CRUD OPERATIONS ====================

  /// INSERT - Inserir nova tarefa
  Future<int> inserirTarefa(Tarefa tarefa) async {
    final db = await database;
    try {
      int id = await db.insert(
        _tableName,
        tarefa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final tarefaComId = tarefa.copyWith(id: id);
      print('✅ Tarefa inserida com sucesso:\n${jsonEncode(tarefaComId.toJson())}');
      return id;
    } catch (e) {
      print('❌ Erro ao inserir tarefa: $e');
      rethrow;
    }
  }

  /// READ - Listar todas as tarefas
  Future<List<Tarefa>> listarTarefas() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(_tableName);

      if (maps.isEmpty) {
        return [];
      }

      return List.generate(maps.length, (i) {
        return Tarefa.fromMap(maps[i]);
      });
    } catch (e) {
      print('❌ Erro ao listar tarefas: $e');
      rethrow;
    }
  }

  /// READ - Obter tarefa por ID
  Future<Tarefa?> obterTarefaPorId(int id) async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Tarefa.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('❌ Erro ao obter tarefa: $e');
      rethrow;
    }
  }

  /// UPDATE - Editar tarefa existente
  Future<int> editarTarefa(Tarefa tarefa) async {
    final db = await database;
    try {
      int linhasAtualizadas = await db.update(
        _tableName,
        tarefa.toMap(),
        where: 'id = ?',
        whereArgs: [tarefa.id],
      );
      print('✅ Tarefa atualizada: $linhasAtualizadas linha(s)');
      return linhasAtualizadas;
    } catch (e) {
      print('❌ Erro ao editar tarefa: $e');
      rethrow;
    }
  }

  /// DELETE - Deletar tarefa
  Future<int> deletarTarefa(int id) async {
    final db = await database;
    try {
      int linhasDeletadas = await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      print('✅ Tarefa deletada: $linhasDeletadas linha(s)');
      return linhasDeletadas;
    } catch (e) {
      print('❌ Erro ao deletar tarefa: $e');
      rethrow;
    }
  }

  /// DELETE ALL - Limpar todas as tarefas
  Future<int> deletarTodasTarefas() async {
    final db = await database;
    try {
      int linhasDeletadas = await db.delete(_tableName);
      print('✅ Todas as tarefas foram deletadas');
      return linhasDeletadas;
    } catch (e) {
      print('❌ Erro ao deletar todas as tarefas: $e');
      rethrow;
    }
  }

  /// Obter caminho do banco de dados (para debugging)
  Future<String> getDatabasePath() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, _dbName);
  }

  /// Contar tarefas totais
  Future<int> contarTarefas() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $_tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Contar tarefas sincronizadas
  Future<int> contarTarefasSincronizadas() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $_tableName WHERE flagSincronizado = 1'
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}