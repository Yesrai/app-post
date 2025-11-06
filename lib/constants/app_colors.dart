import 'package:flutter/material.dart';

/// Constantes de colores para la app TaskifyApp
class AppColors {
  // Colores principales
  static const Color lavanda = Color(0xFF8A7BFF);
  static const Color menta = Color(0xFF8EE7C0);
  static const Color grisClaro = Color(0xFFF7F8FB);
  static const Color blanco = Color(0xFFFFFFFF);

  // Colores de texto
  static const Color textPrincipal = Color(0xFF2D3436);
  static const Color textSecundario = Color(0xFF636E72);
  static const Color textPlaceholder = Color(0xFFBDBDBD);

  // Colores de bordes
  static const Color borderLight = Color(0xFFE8EBED);
  static const Color borderMedium = Color(0xFFDFDFDF);

  // Colores de estados
  static const Color success = menta;
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFEF5350);
  static const Color info = lavanda;

  // Colores de estados de tareas
  static const Color estadoPendiente = lavanda;
  static const Color estadoCompletada = menta;

  // Sombras
  static const BoxShadow shadowSuave = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );

  static const BoxShadow shadowMedium = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  // Gradientes
  static const LinearGradient gradientPrincipal = LinearGradient(
    colors: [lavanda, Color(0xFF7C6FE8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientSuccess = LinearGradient(
    colors: [menta, Color(0xFF7FD7B0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
