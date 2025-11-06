/// Modelo de Tarea para gestionar tareas académicas o personales
class Tarea {
  final int? id;
  final String titulo;
  final String descripcion;
  final String fechaEntrega;
  final String estado; // PENDIENTE / COMPLETADA

  Tarea({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaEntrega,
    required this.estado,
  });

  /// Convierte JSON del backend a objeto Tarea
  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      fechaEntrega: json['fechaEntrega'] ?? '',
      estado: json['estado'] ?? 'PENDIENTE',
    );
  }

  /// Convierte objeto Tarea a JSON para enviar al backend
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaEntrega': fechaEntrega,
      'estado': estado,
    };
  }

  /// Copia la tarea con nuevos valores (útil para ediciones)
  Tarea copyWith({
    int? id,
    String? titulo,
    String? descripcion,
    String? fechaEntrega,
    String? estado,
  }) {
    return Tarea(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      fechaEntrega: fechaEntrega ?? this.fechaEntrega,
      estado: estado ?? this.estado,
    );
  }

  @override
  String toString() =>
      'Tarea(id: $id, titulo: $titulo, estado: $estado, fechaEntrega: $fechaEntrega)';
}
