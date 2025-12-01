import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tarefa_model.dart';
import '../database/database_helper.dart';
import '../themes/app_theme.dart';
import 'formulario_screen.dart';
import 'detalhes_screen.dart';

class ListagemScreen extends StatefulWidget {
  const ListagemScreen({Key? key}) : super(key: key);

  @override
  State<ListagemScreen> createState() => _ListagemScreenState();
}

class _ListagemScreenState extends State<ListagemScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Tarefa> _tarefas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    setState(() => _carregando = true);
    try {
      final tarefas = await _dbHelper.listarTarefas();
      setState(() {
        _tarefas = tarefas;
        _carregando = false;
      });
    } catch (e) {
      setState(() => _carregando = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar tarefas: $e')),
        );
      }
    }
  }

  Future<void> _deletarTarefa(int id) async {
    final confirmacao = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Tarefa'),
        content: const Text('Tem certeza que deseja deletar esta tarefa?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Deletar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmacao == true) {
      try {
        await _dbHelper.deletarTarefa(id);
        _carregarTarefas();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tarefa deletada com sucesso')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao deletar: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📋 Task Manager'),
        elevation: 4,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                '${_tarefas.length} tarefa${_tarefas.length != 1 ? 's' : ''}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _tarefas.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.task_alt, size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma tarefa cadastrada',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Clique no + para criar uma nova tarefa',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _tarefas.length,
                  itemBuilder: (context, index) {
                    final tarefa = _tarefas[index];
                    final dataFormatada = DateFormat('dd/MM/yyyy HH:mm')
                        .format(DateTime.parse(tarefa.criadoEm));

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.obterCorPrioridade(tarefa.prioridade),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            AppTheme.obterIconePrioridade(tarefa.prioridade),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          tarefa.titulo,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              tarefa.descricao,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  dataFormatada,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey[600]),
                                ),
                                const SizedBox(width: 12),
                                if (tarefa.flagSincronizado == 1)
                                  Chip(
                                    label: const Text('Sincronizado',
                                        style: TextStyle(fontSize: 10)),
                                    backgroundColor: Colors.green[100],
                                    labelStyle:
                                        TextStyle(color: Colors.green[700]),
                                    visualDensity: VisualDensity.compact,
                                  ),
                              ],
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'editar') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FormularioScreen(tarefa: tarefa),
                                ),
                              ).then((_) => _carregarTarefas());
                            } else if (value == 'deletar') {
                              _deletarTarefa(tarefa.id!);
                            } else if (value == 'detalhes') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetalhesScreen(tarefa: tarefa),
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'detalhes',
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, size: 18),
                                  SizedBox(width: 8),
                                  Text('Ver Detalhes'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'editar',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 18),
                                  SizedBox(width: 8),
                                  Text('Editar'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'deletar',
                              child: Row(
                                children: [
                                  const Icon(Icons.delete,
                                      size: 18, color: Colors.red),
                                  const SizedBox(width: 8),
                                  Text('Deletar',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormularioScreen()),
          ).then((_) => _carregarTarefas());
        },
        tooltip: 'Nova Tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}