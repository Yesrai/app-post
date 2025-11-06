import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarea.dart';
import '../providers/tarea_provider.dart';

/// Página para crear o editar una tarea
class AddEditTareaPage extends StatefulWidget {
  final Tarea? tarea; // Si es null, es crear. Si no, es editar.

  const AddEditTareaPage({Key? key, this.tarea}) : super(key: key);

  @override
  State<AddEditTareaPage> createState() => _AddEditTareaPageState();
}

class _AddEditTareaPageState extends State<AddEditTareaPage> {
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  late TextEditingController _fechaController;
  String _estado = 'PENDIENTE';
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Inicializar controladores
    _tituloController = TextEditingController(text: widget.tarea?.titulo ?? '');
    _descripcionController =
        TextEditingController(text: widget.tarea?.descripcion ?? '');
    _fechaController = TextEditingController(text: widget.tarea?.fechaEntrega ?? '');
    _estado = widget.tarea?.estado ?? 'PENDIENTE';
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  /// Abre el selector de fecha
  Future<void> _seleccionarFecha() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaController.text.isNotEmpty
          ? DateTime.parse(_fechaController.text)
          : now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF8A7BFF),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8A7BFF),
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _fechaController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  /// Guarda la tarea (crear o editar)
  Future<void> _guardarTarea() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    final tarea = Tarea(
      id: widget.tarea?.id,
      titulo: _tituloController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      fechaEntrega: _fechaController.text.trim(),
      estado: _estado,
    );

    final provider = context.read<TareaProvider>();
    bool exito = false;

    if (widget.tarea == null) {
      // Crear nueva tarea
      exito = await provider.crearTarea(tarea);
    } else {
      // Editar tarea existente
      exito = await provider.actualizarTarea(widget.tarea!.id ?? 0, tarea);
    }

    setState(() => _isLoading = false);

    if (mounted) {
      if (exito) {
        Navigator.pop(context, true);
      } else {
        _mostrarError(provider.errorMessage ?? 'Error desconocido');
      }
    }
  }

  /// Muestra un snackbar de error
  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
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
          widget.tarea == null ? 'Nueva Tarea' : 'Editar Tarea',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D3436),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2D3436)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo: Título
              _buildLabelField('Título'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  hintText: 'Ej: Estudiar matemáticas',
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFF636E72)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE8EBED),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFE8EBED),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF8A7BFF),
                      width: 2,
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es requerido';
                  }
                  if (value.length < 3) {
                    return 'El título debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo: Descripción
              _buildLabelField('Descripción'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descripcionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe la tarea que debes realizar...',
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFF636E72)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE8EBED)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE8EBED)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF8A7BFF),
                      width: 2,
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La descripción es requerida';
                  }
                  if (value.length < 5) {
                    return 'La descripción debe tener al menos 5 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo: Fecha de Entrega
              _buildLabelField('Fecha de Entrega'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fechaController,
                readOnly: true,
                onTap: _seleccionarFecha,
                decoration: InputDecoration(
                  hintText: 'yyyy-MM-dd',
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFF636E72)),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.calendar_today,
                      color: Color(0xFF8A7BFF),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE8EBED)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE8EBED)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF8A7BFF),
                      width: 2,
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La fecha es requerida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo: Estado
              _buildLabelField('Estado'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE8EBED)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: _estado,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'PENDIENTE', child: Text('PENDIENTE')),
                    DropdownMenuItem(
                        value: 'COMPLETADA', child: Text('COMPLETADA')),
                  ],
                  onChanged: (value) {
                    setState(() => _estado = value ?? 'PENDIENTE');
                  },
                ),
              ),
              const SizedBox(height: 40),

              // Botón Guardar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _guardarTarea,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A7BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          widget.tarea == null ? 'Crear Tarea' : 'Guardar Cambios',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget para las etiquetas de los campos
  Widget _buildLabelField(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF2D3436),
      ),
    );
  }
}
