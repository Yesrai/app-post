# 💡 Tips y Mejores Prácticas - TaskifyApp

## 🎨 Diseño

### ✅ Paleta de Colores
- Utiliza `AppColors` para mantener consistencia
- Evita hardcodear colores en widgets
- Usa colores con opacidad para jerarquía visual

```dart
// ✅ BIEN
Container(
  color: AppColors.lavanda.withOpacity(0.1),
)

// ❌ MAL
Container(
  color: Color(0xFF8A7BFF).withOpacity(0.1),
)
```

### ✅ BorderRadius Consistente
- Utiliza `16` para componentes principales
- Utiliza `12` para botones e inputs
- Utiliza `8` para íconos y controles pequeños

```dart
BorderRadius.circular(16)    // Tarjetas, diálogos
BorderRadius.circular(12)    // Botones, campos
BorderRadius.circular(8)     // Controles pequeños
```

### ✅ Sombras Sutiles
- Las sombras dan profundidad sin recargar
- Úsalas con `blurRadius: 12` y `offset: Offset(0, 4)`

```dart
BoxShadow(
  color: Colors.black.withOpacity(0.05),
  blurRadius: 12,
  offset: const Offset(0, 4),
)
```

---

## 🏗️ Arquitectura

### ✅ Separación de Responsabilidades

```dart
// ✅ BIEN - Cada clase tiene una responsabilidad
class TareaModel { /* Solo datos */ }
class TareaService { /* Solo HTTP */ }
class TareaProvider { /* Solo estado */ }
class ListaTareasPage { /* Solo UI */ }

// ❌ MAL - Todo mezclado
class TareaPage { /* Datos, HTTP, lógica, UI */ }
```

---

## 🌐 Conectividad

### ✅ Manejo de Errores HTTP

```dart
// ✅ BIEN - Manejo completo
try {
  final response = await http.get(uri)
    .timeout(Duration(seconds: 10));
  
  if (response.statusCode == 200) {
    return parseData(response.body);
  } else if (response.statusCode == 404) {
    throw Exception('No encontrado');
  }
} catch (e) {
  throw Exception('Error de conexión: $e');
}

// ❌ MAL - Sin manejo
final response = await http.get(uri);
return parseData(response.body);
```

### ✅ Base URL Flexible

```dart
// ✅ BIEN - Fácil de cambiar
static const String baseUrl = 'http://localhost:8080/api/tareas';

// Para emulador Android: 'http://10.0.2.2:8080/api/tareas'
// Para dispositivo: 'http://192.168.X.X:8080/api/tareas'
```

---

## 📊 Provider Pattern

### ✅ Estructura Correcta

```dart
// ✅ BIEN
class TareaProvider extends ChangeNotifier {
  List<Tarea> _tareas = [];        // Estado privado
  bool _isLoading = false;
  String? _errorMessage;
  
  List<Tarea> get tareas => _tareas;  // Getters públicos
  bool get isLoading => _isLoading;
  
  Future<void> cargarTareas() async {  // Métodos
    _isLoading = true;
    notifyListeners();
    try {
      // lógica
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// ❌ MAL - Estado público
class TareaProvider extends ChangeNotifier {
  List<Tarea> tareas = [];  // ❌ Público
}
```

### ✅ Usar Consumer Correctamente

```dart
// ✅ BIEN
Consumer<TareaProvider>(
  builder: (context, provider, child) {
    return Text(provider.tareas.length.toString());
  },
)

// ✅ MÁS EFICIENTE
Selector<TareaProvider, int>(
  selector: (_, provider) => provider.tareas.length,
  builder: (_, count, __) => Text(count.toString()),
)
```

---

## 🎯 Formularios

### ✅ Validación Correcta

```dart
// ✅ BIEN
TextFormField(
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Requerido';
    }
    if (value.length < 3) {
      return 'Mínimo 3 caracteres';
    }
    return null;
  },
)

// ❌ MAL
TextFormField(
  validator: (value) => value?.isEmpty ?? true ? 'Error' : null,
)
```

### ✅ Manejo de Formularios

```dart
// ✅ BIEN
final _formKey = GlobalKey<FormState>();

void _guardar() {
  if (!_formKey.currentState!.validate()) return;
  // Guardar datos
}
```

---

## 🔄 Ciclo de Vida

### ✅ initState y dispose

```dart
// ✅ BIEN
class _PageState extends State<Page> {
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ❌ MAL - Memory leak
@override
void dispose() {
  super.dispose();
  // ❌ Nunca dispose el controlador
}
```

---

## 📱 UI/UX

### ✅ Loading States

```dart
// ✅ BIEN
if (provider.isLoading && provider.tareas.isEmpty) {
  return CircularProgressIndicator();
}

// Si hay datos, mostrar con estado semi-transparente
```

### ✅ Estados Vacíos

```dart
// ✅ BIEN
if (provider.tareas.isEmpty) {
  return Center(
    child: Column(
      children: [
        Icon(Icons.task_alt, size: 64),
        Text('No hay tareas'),
      ],
    ),
  );
}
```

### ✅ Retroalimentación

```dart
// ✅ BIEN - SnackBar moderno
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Tarea creada'),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
```

---

## 🚀 Performance

### ✅ Optimización de Builds

```dart
// ✅ BIEN - Usar const
const SizedBox(height: 16)
const Text('Texto')

// ✅ BIEN - ListView.builder
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)

// ❌ MAL - Sin const
SizedBox(height: 16)

// ❌ MAL - ListView con muchos items
ListView(
  children: items.map((item) => ItemWidget(item)).toList(),
)
```

---

## 📝 Convenciones

### ✅ Nombres Claros

```dart
// ✅ BIEN
final _tituloController = TextEditingController();
void _mostrarDialogoEliminar() { }
bool _esValido() { }

// ❌ MAL
final ctrl = TextEditingController();
void showDialog() { }
bool valid() { }
```

---

**¡Sigue estas prácticas para código limpio y mantenible! 🚀**
