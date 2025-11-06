import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tarea.dart';

/// Widget personalizado para mostrar una tarea en forma de tarjeta
class TareaCard extends StatelessWidget {
  final Tarea tarea;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TareaCard({
    Key? key,
    required this.tarea,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  /// Retorna el color según el estado de la tarea
  Color _getEstadoColor() {
    return tarea.estado == 'COMPLETADA'
        ? const Color(0xFF8EE7C0) // Menta
        : const Color(0xFF8A7BFF); // Lavanda
  }

  /// Retorna el ícono según el estado
  IconData _getEstadoIcon() {
    return tarea.estado == 'COMPLETADA' ? Icons.check_circle : Icons.schedule;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado: Título y Estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tarea.titulo,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D3436),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getEstadoColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getEstadoIcon(),
                        size: 14,
                        color: _getEstadoColor(),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        tarea.estado,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _getEstadoColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Descripción
            Text(
              tarea.descripcion,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF636E72),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // Fecha y botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: const Color(0xFF8A7BFF),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tarea.fechaEntrega,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF636E72),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Botón Editar
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A7BFF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Color(0xFF8A7BFF),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Botón Eliminar
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.delete,
                          size: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
