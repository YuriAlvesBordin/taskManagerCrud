import 'package:flutter/material.dart';
import '../models/tarefa_model.dart';
import '../database/database_helper.dart';
import '../themes/app_theme.dart';

class FormularioScreen extends StatefulWidget {
  final Tarefa? tarefa;

  const FormularioScreen({Key? key, this.tarefa}) : super(key: key);

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _carregando = false;

  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  String _prioridadeSelecionada = 'MÉDIA';
  bool _flagSincronizado = false;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tarefa?.titulo ?? '');
    _descricaoController =
        TextEditingController(text: widget.tarefa?.descricao ?? '');
    _prioridadeSelecionada = widget.tarefa?.prioridade ?? 'MÉDIA';
    _flagSincronizado = widget.tarefa?.flagSincronizado == 1;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvarTarefa() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    try {
      final agora = DateTime.now().toIso8601String();

      final tarefa = Tarefa(
        id: widget.tarefa?.id,
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
        prioridade: _prioridadeSelecionada,
        criadoEm: widget.tarefa?.criadoEm ?? agora,
        flagSincronizado: _flagSincronizado ? 1 : 0,
      );

      if (widget.tarefa == null) {
        await _dbHelper.inserirTarefa(tarefa);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Tarefa criada com sucesso!')),
          );
        }
      } else {
        await _dbHelper.editarTarefa(tarefa);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Tarefa atualizada com sucesso!')),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Erro ao salvar: $e')),
        );
      }
    } finally {
      setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdicao = widget.tarefa != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdicao ? '✏️ Editar Tarefa' : '➕ Nova Tarefa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título *',
                  hintText: 'Digite o título da tarefa',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite um título';
                  }
                  if (value.length < 3) {
                    return 'Título deve ter no mínimo 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição da tarefa',
                  prefixIcon: Icon(Icons.description),
                ),
                minLines: 3,
                maxLines: 5,
                validator: (value) {
                  if (value != null && value.length > 500) {
                    return 'Descrição não pode ter mais de 500 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _prioridadeSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Prioridade *',
                  prefixIcon: Icon(Icons.priority_high),
                ),
                items: ['BAIXA', 'MÉDIA', 'ALTA']
                    .map((prioridade) => DropdownMenuItem(
                          value: prioridade,
                          child: Row(
                            children: [
                              Icon(
                                AppTheme.obterIconePrioridade(prioridade),
                                color: AppTheme.obterCorPrioridade(prioridade),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(prioridade),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() =>
                      _prioridadeSelecionada = value ?? 'MÉDIA');
                },
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.cloud_sync, color: Colors.blue),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sincronizar Tarefa',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Marcar como sincronizado',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: _flagSincronizado,
                        onChanged: (value) {
                          setState(() => _flagSincronizado = value);
                        },
                        activeColor: AppTheme.corSecundaria,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _carregando ? null : _salvarTarefa,
                      child: _carregando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            )
                          : Text(isEdicao ? 'Atualizar' : 'Salvar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}