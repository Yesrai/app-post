import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/tarea.dart';
import '../providers/tarea_provider.dart';
import '../widgets/tarea_card.dart';
import 'add_edit_tarea_page.dart';

/// Página principal que lista todas las tareas
class ListaTareasPage extends StatefulWidget {
  const ListaTareasPage({Key? key}) : super(key: key);

  @override
  State<ListaTareasPage> createState() => _ListaTareasPageState();
}

class _ListaTareasPageState extends State<ListaTareasPage> {
  @override
  void initState() {
    super.initState();
    // Cargar tareas al iniciar la página
    Future.delayed(Duration.zero, () {
      context.read<TareaProvider>().cargarTareas();
    });
  }

  /// Muestra diálogo de confirmación antes de eliminar
  void _mostrarDialogoEliminar(BuildContext context, Tarea tarea) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          '¿Eliminar tarea?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar "${tarea.titulo}"?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(color: const Color(0xFF636E72)),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (mounted) {
                await context.read<TareaProvider>().eliminarTarea(tarea.id ?? 0);
                if (mounted) {
                  _mostrarSnackbar('Tarea eliminada', isError: false);
                }
              }
            },
            child: Text(
              'Eliminar',
              style: GoogleFonts.poppins(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  /// Muestra un SnackBar con mensaje
  void _mostrarSnackbar(String mensaje, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensaje,
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: isError ? Colors.red : const Color(0xFF8EE7C0),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'TaskifyApp',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D3436),
          ),
        ),
        centerTitle: false,
      ),
      body: Consumer<TareaProvider>(
        builder: (context, provider, child) {
          // Si está cargando
          if (provider.isLoading && provider.tareas.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: const Color(0xFF8A7BFF),
              ),
            );
          }

          // Si hay error
          if (provider.errorMessage != null && provider.tareas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar tareas',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      provider.errorMessage ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF636E72),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => provider.cargarTareas(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A7BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Reintentar',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // Si no hay tareas
          if (provider.tareas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 64,
                    color: const Color(0xFF8A7BFF).withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay tareas',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Crea tu primera tarea para comenzar',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF636E72),
                    ),
                  ),
                ],
              ),
            );
          }

          // Lista de tareas con RefreshIndicator
          return RefreshIndicator(
            color: const Color(0xFF8A7BFF),
            onRefresh: () => provider.cargarTareas(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Estadísticas
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        _buildStatCard(
                          label: 'Total',
                          value: provider.totalTareas.toString(),
                          color: const Color(0xFF8A7BFF),
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          label: 'Pendientes',
                          value: provider.tareasPendientes.toString(),
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          label: 'Completadas',
                          value: provider.tareasCompletadas.toString(),
                          color: const Color(0xFF8EE7C0),
                        ),
                      ],
                    ),
                  ),
                  // Lista de tareas
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = provider.tareas[index];
                      return TareaCard(
                        tarea: tarea,
                        onEdit: () async {
                          final resultado = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditTareaPage(tarea: tarea),
                            ),
                          );
                          if (resultado == true && mounted) {
                            _mostrarSnackbar('Tarea actualizada');
                          }
                        },
                        onDelete: () => _mostrarDialogoEliminar(context, tarea),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final resultado = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditTareaPage(),
            ),
          );
          if (resultado == true && mounted) {
            _mostrarSnackbar('Tarea creada');
          }
        },
        backgroundColor: const Color(0xFF8A7BFF),
        label: Text(
          'Nueva Tarea',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }

  /// Widget para mostrar estadísticas
  Widget _buildStatCard({
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
