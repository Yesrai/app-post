import 'package:flutter/foundation.dart';
import '../models/tarea.dart';
import '../services/tarea_service.dart';

/// Provider que gestiona el estado de las tareas usando ChangeNotifier
class TareaProvider extends ChangeNotifier {
  final TareaService _tareaService = TareaService();

  List<Tarea> _tareas = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Tarea> get tareas => _tareas;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Carga todas las tareas desde el backend
  Future<void> cargarTareas() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tareas = await _tareaService.obtenerTareas();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al cargar tareas: ${e.toString()}';
      _tareas = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Crea una nueva tarea
  Future<bool> crearTarea(Tarea tarea) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final nuevaTarea = await _tareaService.crearTarea(tarea);
      _tareas.add(nuevaTarea);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al crear tarea: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Actualiza una tarea existente
  Future<bool> actualizarTarea(int id, Tarea tarea) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final tareaActualizada = await _tareaService.actualizarTarea(id, tarea);
      final index = _tareas.indexWhere((t) => t.id == id);
      if (index != -1) {
        _tareas[index] = tareaActualizada;
      }
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al actualizar tarea: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Elimina una tarea
  Future<bool> eliminarTarea(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _tareaService.eliminarTarea(id);
      _tareas.removeWhere((t) => t.id == id);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al eliminar tarea: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Limpia el mensaje de error
  void limpiarError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Retorna el número total de tareas
  int get totalTareas => _tareas.length;

  /// Retorna el número de tareas completadas
  int get tareasCompletadas =>
      _tareas.where((t) => t.estado == 'COMPLETADA').length;

  /// Retorna el número de tareas pendientes
  int get tareasPendientes =>
      _tareas.where((t) => t.estado == 'PENDIENTE').length;
}
