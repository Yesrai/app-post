// Widget tests for TaskifyApp
//
// Esta suite de pruebas verifica que los widgets de TaskifyApp
// se construyen correctamente y funcionan como se espera.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_drud/main.dart';

void main() {
  group('TaskifyApp - Widget Tests', () {
    testWidgets('TaskifyApp se renderiza sin errores', (WidgetTester tester) async {
      // Construir la app
      await tester.pumpWidget(const TaskifyApp());

      // Verificar que la app se cargó
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('TaskifyApp'), findsWidgets);
    });

    testWidgets('ListaTareasPage se muestra correctamente', (WidgetTester tester) async {
      // Construir la app
      await tester.pumpWidget(const TaskifyApp());
      await tester.pumpAndSettle();

      // Verificar que el AppBar está presente
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('TaskifyApp'), findsWidgets);

      // Verificar que el FAB existe
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('FAB para crear tarea está presente', (WidgetTester tester) async {
      // Construir la app
      await tester.pumpWidget(const TaskifyApp());
      await tester.pumpAndSettle();

      // Verificar que hay un FAB con icono de agregar
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Verificar el texto del FAB
      expect(find.text('Nueva Tarea'), findsOneWidget);
    });

    testWidgets('Tema está configurado correctamente', (WidgetTester tester) async {
      // Construir la app
      await tester.pumpWidget(const TaskifyApp());

      // Verificar que el tema tiene las propiedades correctas
      final theme = Theme.of(tester.element(find.byType(MaterialApp)));
      expect(theme.useMaterial3, isTrue);
      expect(theme.primaryColor, const Color(0xFF8A7BFF));
    });

    testWidgets('Provider está correctamente configurado', (WidgetTester tester) async {
      // Construir la app
      await tester.pumpWidget(const TaskifyApp());

      // Verificar que TareaProvider está disponible
      expect(
        find.byType(MultiProvider),
        findsOneWidget,
        reason: 'MultiProvider debe estar en la raíz de la app',
      );
    });
  });
}
