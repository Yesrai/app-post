# 🎯 TaskifyApp - Flutter CRUD Aesthetic

Una aplicación Flutter **completa y moderna** que implementa un CRUD (Create, Read, Update, Delete) de tareas, conectada a un backend REST construido con Spring Boot.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Dart](https://img.shields.io/badge/Dart-3.x-blue)
![License](https://img.shields.io/badge/license-MIT-green)

---

## ✨ Características Principales

### 🎨 Diseño Aesthetic
- ✅ **Paleta de colores suave**: Lavanda, Menta, Grises, Blanco
- ✅ **BorderRadius redondeado**: 16px en todos los componentes
- ✅ **Sombras sutiles**: Efecto depth elegante
- ✅ **Tipografía Google Fonts Poppins**: Moderna y legible
- ✅ **Animaciones suaves**: Transiciones y efectos visuales

### 💯 Funcionalidades CRUD
- ✅ **Listar tareas**: Con RefreshIndicator pull-to-refresh
- ✅ **Crear tarea**: Formulario con validación
- ✅ **Editar tarea**: Modificar cualquier campo existente
- ✅ **Eliminar tarea**: Con diálogo de confirmación
- ✅ **Ver detalles**: Información completa por tarea

### 🏗️ Arquitectura Profesional
- ✅ **Provider Pattern**: Manejo de estado robusto
- ✅ **Separación de responsabilidades**: Modelos, Servicios, Providers, Páginas
- ✅ **HTTP Client**: Comunicación segura con backend
- ✅ **Manejo de errores**: Validaciones y mensajes de error
- ✅ **UI/UX moderno**: FloatingActionButton, Cards, Dialogs

### 📊 Estadísticas
- ✅ Dashboard con contadores: Total, Pendientes, Completadas
- ✅ Filtrado por estado
- ✅ Indicador de progreso visual

---

## 🚀 Inicio Rápido

### 1️⃣ Requisitos Previos

```bash
# Flutter
flutter --version          # Debe ser 3.x o superior
dart --version            # Debe ser 3.x o superior

# Backend
- Spring Boot 3.x
- MySQL Server
- JDK 17+
```

### 2️⃣ Clonar/Descargar Proyecto

```bash
cd /path/to/app-post-dam
```

### 3️⃣ Instalar Dependencias

```bash
flutter pub get
```

### 4️⃣ Configurar Backend URL

Editar `lib/services/tarea_service.dart`:

```dart
// Para iOS Simulator (recomendado para desarrollo)
static const String baseUrl = 'http://localhost:8080/api/tareas';

// Para Android Emulator
// static const String baseUrl = 'http://10.0.2.2:8080/api/tareas';

// Para dispositivo físico (reemplazar con tu IP local)
// static const String baseUrl = 'http://192.168.X.X:8080/api/tareas';
```

### 5️⃣ Ejecutar la App

```bash
# Iniciar backend Spring Boot
cd /path/to/backend
mvn spring-boot:run

# En otra terminal, iniciar la app Flutter
flutter run

# O para modo release:
flutter run --release
```

---

## 📱 Pantallas de la Aplicación

### 📋 Pantalla Principal - ListaTareasPage

**Funciones:**
- Lista completa de tareas
- Estadísticas: Total, Pendientes, Completadas
- Botones de editar y eliminar por tarea
- FAB para crear nueva tarea
- Pull-to-refresh para recargar

```dart
// Componentes principales
- AppBar con título "TaskifyApp"
- Estadísticas en cards
- ListView con TareaCards
- RefreshIndicator
- FloatingActionButton extendido
```

### ➕ Pantalla Crear/Editar - AddEditTareaPage

**Campos del formulario:**
- 📝 **Título**: TextFormField con validación (mínimo 3 caracteres)
- 📄 **Descripción**: MultiLine TextFormField (mínimo 5 caracteres)
- 📅 **Fecha de Entrega**: DatePicker (formato yyyy-MM-dd)
- 🔘 **Estado**: Dropdown (PENDIENTE / COMPLETADA)

**Validaciones:**
- Título requerido y mínimo 3 caracteres
- Descripción requerida y mínimo 5 caracteres
- Fecha requerida en formato válido
- Estado seleccionado

---

## 🎨 Paleta de Colores

| Nombre | Código | Hex | Uso |
|--------|--------|-----|-----|
| Lavanda | `Color(0xFF8A7BFF)` | `#8A7BFF` | Primario, botones, iconos |
| Menta | `Color(0xFF8EE7C0)` | `#8EE7C0` | Completada, acentos |
| Gris Oscuro | `Color(0xFF2D3436)` | `#2D3436` | Texto principal |
| Gris Medio | `Color(0xFF636E72)` | `#636E72` | Texto secundario |
| Gris Claro | `Color(0xFFF7F8FB)` | `#F7F8FB` | Fondo |
| Blanco | `Color(0xFFFFFFFF)` | `#FFFFFF` | Cards, inputs |

---

## 📦 Estructura del Proyecto

```
lib/
├── models/
│   └── tarea.dart                 # 📊 Modelo de datos
│
├── services/
│   └── tarea_service.dart         # 🌐 Cliente HTTP
│
├── providers/
│   └── tarea_provider.dart        # 🎯 Manejo de estado
│
├── pages/
│   ├── lista_tareas_page.dart     # 📋 Pantalla principal
│   └── add_edit_tarea_page.dart   # ➕ Formulario
│
├── widgets/
│   └── tarea_card.dart            # 🎨 Card personalizado
│
├── constants/
│   └── app_colors.dart            # 🎨 Colores constantes
│
└── main.dart                       # 🚀 Punto de entrada
```

---

## 🔧 Configuración Detallada

### Backend (Spring Boot)

**Entidad Tarea:**
```java
@Entity
public class Tarea {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titulo;
    private String descripcion;
    private LocalDate fechaEntrega;
    private String estado; // PENDIENTE / COMPLETADA
}
```

**Controlador REST:**
```java
@RestController
@RequestMapping("/api/tareas")
public class TareaController {
    @GetMapping                      // GET /api/tareas
    @GetMapping("/{id}")             // GET /api/tareas/{id}
    @PostMapping                     // POST /api/tareas
    @PutMapping("/{id}")             // PUT /api/tareas/{id}
    @DeleteMapping("/{id}")          // DELETE /api/tareas/{id}
}
```

### Base de Datos (MySQL)

```sql
CREATE TABLE tarea (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_entrega DATE NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'PENDIENTE'
);
```

---

## 🧪 Pruebas de la API

### Usando curl

```bash
# Listar todas las tareas
curl -X GET http://localhost:8080/api/tareas

# Crear tarea
curl -X POST http://localhost:8080/api/tareas \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Mi tarea",
    "descripcion": "Descripción...",
    "fechaEntrega": "2025-11-20",
    "estado": "PENDIENTE"
  }'

# Actualizar tarea
curl -X PUT http://localhost:8080/api/tareas/1 \
  -H "Content-Type: application/json" \
  -d '{...}'

# Eliminar tarea
curl -X DELETE http://localhost:8080/api/tareas/1
```

### Usando Postman/Thunder Client

1. Importar: `TaskifyApp_API_Collection.json`
2. Configurar variable `baseUrl` si es necesario
3. Ejecutar requests en orden

---

## 📚 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Cliente HTTP para comunicarse con el backend
  http: ^1.2.0
  
  # Manejo de estado (Provider Pattern)
  provider: ^6.4.0
  
  # Tipografía personalizada (Google Fonts)
  google_fonts: ^6.2.1
  
  # Internacionalización y formatos de fecha
  intl: ^0.20.1
  
  # Iconos iOS
  cupertino_icons: ^1.0.8
```

---

## 🐛 Solución de Problemas

### ❌ Error: "Cannot connect to backend"
```bash
# Verificar que el backend está corriendo
curl http://localhost:8080/api/tareas

# Para Android Emulator, cambiar URL a:
http://10.0.2.2:8080/api/tareas

# Para dispositivo físico, usar IP local:
http://192.168.X.X:8080/api/tareas
```

### ❌ Error: "Timeout"
- Aumentar timeout en `tarea_service.dart`
- Verificar que el backend no está lento
- Revisar la conexión de red

### ❌ No se cargan las tareas
- Verificar MySQL está corriendo
- Revisar que hay datos en la tabla `tarea`
- Ver logs del backend

### ❌ Errores de validación
- Revisar formato de fecha: `yyyy-MM-dd`
- Título debe tener mínimo 3 caracteres
- Descripción debe tener mínimo 5 caracteres
- Estado debe ser `PENDIENTE` o `COMPLETADA`

---

## 🎯 Casos de Uso

### 1️⃣ Crear una tarea
```
1. Tap en "Nueva Tarea" (FAB)
2. Completa el formulario
3. Selecciona la fecha con DatePicker
4. Tap en "Crear Tarea"
5. ✅ La tarea aparece en la lista
```

### 2️⃣ Editar una tarea
```
1. Tap en el ícono de editar en la tarjeta
2. Modifica los campos deseados
3. Tap en "Guardar Cambios"
4. ✅ Los cambios se reflejan en la lista
```

### 3️⃣ Eliminar una tarea
```
1. Tap en el ícono de eliminar en la tarjeta
2. Confirma en el diálogo
3. ✅ La tarea se elimina de la lista
```

### 4️⃣ Recargar lista
```
1. Swipe down (pull-to-refresh)
2. ✅ La lista se actualiza con las últimas tareas
```

---

## 📋 Checklist de Implementación

- ✅ Modelo `Tarea` con toJson/fromJson
- ✅ Servicio HTTP `TareaService` con 5 métodos CRUD
- ✅ Provider `TareaProvider` con ChangeNotifier
- ✅ Página lista con RefreshIndicator
- ✅ Página formulario con validaciones
- ✅ Widget `TareaCard` personalizado
- ✅ Tema global con colores aesthetic
- ✅ GoogleFonts Poppins
- ✅ Manejo de errores y loading
- ✅ SnackBars y Dialogs
- ✅ Documentación completa

---

## 🚀 Deployment

### Build APK (Android)
```bash
flutter build apk --release
# Ubicación: build/app/outputs/flutter-apk/app-release.apk
```

### Build iOS
```bash
flutter build ios --release
# Ubicación: build/ios/Release
```

---

## 📝 Notas Importantes

1. **Base URL**: Cambiar según el dispositivo (localhost, 10.0.2.2, IP local)
2. **Validaciones**: Se implementan tanto en frontend como en backend
3. **Estados**: Solo aceptan `PENDIENTE` o `COMPLETADA`
4. **Fechas**: Formato requerido: `yyyy-MM-dd`
5. **Sincronización**: La app se sincroniza automáticamente con el backend

---

## 👨‍💻 Autor

Creado con ❤️ para TaskifyApp - 2025

---

## 📄 Licencia

Este proyecto está bajo licencia MIT. Ver `LICENSE` para más detalles.

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📞 Soporte

Para problemas o preguntas:
- Revisa los logs: `flutter logs`
- Consulta la documentación: `TASKIFYAPP_CONFIG.md`
- Verifica el archivo de pruebas: `test_api.sh`

---

**¡Disfruta usando TaskifyApp! 🎉**
