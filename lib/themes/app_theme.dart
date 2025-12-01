import 'package:flutter/material.dart';

class AppTheme {
  // Cores tema temaMetal
  static const Color corPrimaria = Color(0xFF757575); // Grey
  static const Color corSecundaria = Color(0xFF1976D2); // Blue
  static const Color corFundo = Color(0xFFFAFAFA);
  static const Color corTexto = Color(0xFF212121);
  static const Color corTextoSecundario = Color(0xFF757575);

  // Cores de prioridade
  static const Color prioridadeBaixa = Color(0xFF4CAF50); // Green
  static const Color prioridadeMedia = Color(0xFFFFC107); // Amber
  static const Color prioridadeAlta = Color(0xFFF44336); // Red

  static ThemeData obterTema() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: corPrimaria,
        onPrimary: Colors.white,
        secondary: corSecundaria,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: corTexto,
        error: Color(0xFFB00020),
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: corFundo,
      appBarTheme: AppBarTheme(
        backgroundColor: corPrimaria,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: corSecundaria,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: corSecundaria,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: corPrimaria,
          side: BorderSide(color: corPrimaria),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: corSecundaria, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFB00020)),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Obter cor de prioridade
  static Color obterCorPrioridade(String prioridade) {
    switch (prioridade.toUpperCase()) {
      case 'ALTA':
        return prioridadeAlta;
      case 'MÉDIA':
        return prioridadeMedia;
      case 'BAIXA':
        return prioridadeBaixa;
      default:
        return corTextoSecundario;
    }
  }

  /// Obter ícone de prioridade
  static IconData obterIconePrioridade(String prioridade) {
    switch (prioridade.toUpperCase()) {
      case 'ALTA':
        return Icons.priority_high;
      case 'MÉDIA':
        return Icons.adjust;
      case 'BAIXA':
        return Icons.low_priority;
      default:
        return Icons.help_outline;
    }
  }
}