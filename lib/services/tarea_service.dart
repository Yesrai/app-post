import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/tarea.dart';

/// Servicio HTTP para comunicarse con el backend Spring Boot
class TareaService {
  // Base URL para el emulador Android - Cambia según tu configuración
  // Android Emulator: http://10.0.2.2:8080/api/tareas
  // iOS Simulator: http://localhost:8080/api/tareas
  // Physical Device: http://TU_IP_LOCAL:8080/api/tareas (ej: http://192.168.0.100:8080/api/tareas)
  static const String baseUrl = 'http://10.0.2.2:8080/api/tareas';

  /// Obtiene todas las tareas del backend
  Future<List<Tarea>> obtenerTareas() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout al obtener tareas'),
      );

      if (response.statusCode == 200) {
        // El backend retorna un array de tareas
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => Tarea.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        return []; // No hay tareas
      } else {
        throw Exception('Error al obtener tareas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Obtiene una tarea específica por ID
  Future<Tarea> obtenerTareaPorId(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout al obtener tarea'),
      );

      if (response.statusCode == 200) {
        return Tarea.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Tarea no encontrada');
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Crea una nueva tarea
  Future<Tarea> crearTarea(Tarea tarea) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tarea.toJson()),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout al crear tarea'),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Tarea.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error al crear tarea: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Actualiza una tarea existente
  Future<Tarea> actualizarTarea(int id, Tarea tarea) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tarea.toJson()),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout al actualizar tarea'),
      );

      if (response.statusCode == 200) {
        return Tarea.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Tarea no encontrada');
      } else {
        throw Exception('Error al actualizar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Elimina una tarea
  Future<void> eliminarTarea(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout al eliminar tarea'),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Error al eliminar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
