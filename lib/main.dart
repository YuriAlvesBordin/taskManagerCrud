import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'screens/listagem_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MinCadastroApp());
}

class MinCadastroApp extends StatelessWidget {
  const MinCadastroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Cadastro de Tarefas',
      theme: AppTheme.obterTema(),
      debugShowCheckedModeBanner: false,
      home: const ListagemScreen(),
    );
  }
}