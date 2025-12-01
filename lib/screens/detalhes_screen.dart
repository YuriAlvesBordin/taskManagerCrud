import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tarefa_model.dart';
import '../themes/app_theme.dart';

class DetalhesScreen extends StatelessWidget {
  final Tarefa tarefa;

  const DetalhesScreen({Key? key, required this.tarefa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataFormatada =
        DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(tarefa.criadoEm));

    return Scaffold(
      appBar: AppBar(
        title: const Text('📄 Detalhes da Tarefa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Título',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tarefa.titulo,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 24),
                    Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tarefa.descricao.isEmpty
                          ? '(Sem descrição)'
                          : tarefa.descricao,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Divider(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Prioridade',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Chip(
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      AppTheme.obterIconePrioridade(
                                          tarefa.prioridade),
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(tarefa.prioridade),
                                  ],
                                ),
                                backgroundColor: AppTheme.obterCorPrioridade(
                                    tarefa.prioridade),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '#${tarefa.id}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.corSecundaria,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Text(
                      'Data de Criação',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          dataFormatada,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'flagSincronizado',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Chip(
                          label: Text(
                            tarefa.flagSincronizado == 1
                                ? '✓ Sincronizado'
                                : '✗ Não Sincronizado',
                          ),
                          backgroundColor: tarefa.flagSincronizado == 1
                              ? Colors.green[100]
                              : Colors.red[100],
                          labelStyle: TextStyle(
                            color: tarefa.flagSincronizado == 1
                                ? Colors.green[700]
                                : Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'JSON da Tarefa',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  _formatarJson(tarefa.toJson()),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatarJson(Map<String, dynamic> json) {
    StringBuffer buffer = StringBuffer();
    buffer.write('{\n');
    json.forEach((key, value) {
      buffer.write('  "$key": ');
      if (value is String) {
        buffer.write('"$value"');
      } else if (value is bool) {
        buffer.write(value ? 'true' : 'false');
      } else {
        buffer.write(value);
      }
      buffer.write(',\n');
    });
    buffer.write('}');
    return buffer.toString();
  }
}