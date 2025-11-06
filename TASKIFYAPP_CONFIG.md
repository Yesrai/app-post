# TaskifyApp - Configuración Completa

## 🎯 Descripción

**TaskifyApp** es una aplicación Flutter CRUD completa que consume una API REST backend construida con Spring Boot. Permite gestionar tareas académicas y personales de forma aesthetic y moderna.

## ✅ Requisitos Previos

### Backend (Spring Boot)
- ✅ Spring Boot 3.x
- ✅ MySQL configurado
- ✅ Controlador REST con endpoints:
  - `GET /api/tareas` - Listar todas las tareas
  - `GET /api/tareas/{id}` - Obtener una tarea específica
  - `POST /api/tareas` - Crear nueva tarea
  - `PUT /api/tareas/{id}` - Actualizar tarea
  - `DELETE /api/tareas/{id}` - Eliminar tarea

### Configuración Backend (application.properties)
```properties
spring.application.name=app-post
spring.datasource.url=jdbc:mysql://localhost:3306/app?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=admin
spring.jpa.hibernate.ddl-auto=update
spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
```

### Frontend (Flutter)
- ✅ Flutter 3.x
- ✅ Dart 3.x
- ✅ Dependencias instaladas (ver `pubspec.yaml`)

## 📦 Dependencias Flutter

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0              # Cliente HTTP
  provider: ^6.4.0          # Manejo de estado
  google_fonts: ^6.2.1      # Tipografía personalizada
  intl: ^0.20.1             # Internacionalización y fechas
  cupertino_icons: ^1.0.8   # Iconos iOS
```

## 🏗️ Estructura de Carpetas

```
lib/
├── models/
│   └── tarea.dart                 # Modelo de datos Tarea
├── services/
│   └── tarea_service.dart         # Servicio HTTP para comunicarse con backend
├── providers/
│   └── tarea_provider.dart        # Provider con lógica de estado (Provider pattern)
├── pages/
│   ├── lista_tareas_page.dart     # Pantalla de lista de tareas
│   └── add_edit_tarea_page.dart   # Pantalla para crear/editar tarea
├── widgets/
│   └── tarea_card.dart            # Widget personalizado para mostrar una tarea
├── main.dart                       # Punto de entrada de la app
└── app_colors.dart (opcional)     # Colores constantes
```

## 🎨 Paleta de Colores

| Color | Código | Uso |
|-------|--------|-----|
| Lavanda | #8A7BFF | Primario, botones, iconos |
| Menta | #8EE7C0 | Tareas completadas, acentos |
| Gris Oscuro | #2D3436 | Textos principales |
| Gris Medio | #636E72 | Subtextos, descripciones |
| Gris Claro | #F7F8FB | Fondo de la app |
| Blanco | #FFFFFF | Tarjetas, fondos de inputs |

## ⚙️ Configuración Necesaria

### 1️⃣ URL del Backend (iOS Emulator)

En `lib/services/tarea_service.dart`, línea 7:

```dart
static const String baseUrl = 'http://localhost:8080/api/tareas';
```

**Para Android Emulator**, usar:
```dart
static const String baseUrl = 'http://10.0.2.2:8080/api/tareas';
```

**Para dispositivo físico**, usar la IP local de tu máquina:
```dart
static const String baseUrl = 'http://192.168.X.X:8080/api/tareas';
```

### 2️⃣ Instalar Dependencias

```bash
flutter pub get
```

### 3️⃣ Generar APK/IPA

**Para Android:**
```bash
flutter build apk --release
```

**Para iOS:**
```bash
flutter build ios --release
```

## 🚀 Pasos para Ejecutar

### Backend
1. Inicia el servidor Spring Boot:
```bash
mvn spring-boot:run
```
O usando Gradle:
```bash
./gradlew bootRun
```

2. Verifica que está corriendo en `http://localhost:8080`

### Frontend
1. Conecta un dispositivo o inicia el emulador
2. Ejecuta:
```bash
flutter run
```

O en modo release:
```bash
flutter run --release
```

## 📱 Características Implementadas

### ✅ Funcionalidades CRUD
- [x] Listar todas las tareas con RefreshIndicator
- [x] Crear nueva tarea
- [x] Editar tarea existente
- [x] Eliminar tarea con confirmación
- [x] Mostrar errores al usuario

### ✅ Diseño Aesthetic
- [x] Paleta de colores suave (lavanda, menta, grises)
- [x] BorderRadius redondeado (16px)
- [x] Sombras sutiles
- [x] Tipografía GoogleFonts.poppins
- [x] Animaciones sutiles

### ✅ Manejo de Estado
- [x] Provider para gestionar lista de tareas
- [x] Indicadores de carga
- [x] Manejo de errores
- [x] Estadísticas (Total, Pendientes, Completadas)

### ✅ UX/UI Moderno
- [x] FloatingActionButton moderno
- [x] Cards personalizadas por tarea
- [x] Diálogos de confirmación
- [x] SnackBars para retroalimentación
- [x] Pull-to-refresh
- [x] DatePicker personalizado
- [x] Dropdown para estados

## 🧪 Pruebas Recomendadas

### 1. Listar tareas
1. Abre la app
2. Verifica que se cargan las tareas del backend
3. Pull-to-refresh para recargar

### 2. Crear tarea
1. Tap en "Nueva Tarea" (FAB)
2. Completa el formulario
3. Tap en "Crear Tarea"
4. Verifica que aparece en la lista

### 3. Editar tarea
1. Tap en el ícono de editar en una tarea
2. Modifica los campos
3. Tap en "Guardar Cambios"
4. Verifica que se actualizó

### 4. Eliminar tarea
1. Tap en el ícono de eliminar en una tarea
2. Confirma en el diálogo
3. Verifica que desaparece de la lista

### 5. Validaciones
1. Intenta crear tarea sin título
2. Intenta crear tarea con descripción muy corta
3. Verifica mensajes de error

## 🐛 Troubleshooting

### Error: "Cannot connect to backend"
**Solución:**
- Verifica que el backend está corriendo en `http://localhost:8080`
- Comprueba la URL en `tarea_service.dart`
- Para Android emulator, usa `http://10.0.2.2:8080`

### Error: "Timeout"
**Solución:**
- Backend tardando mucho en responder
- Aumenta el timeout en `tarea_service.dart` (línea 18)

### No se cargan las tareas
**Solución:**
- Verifica la base de datos MySQL está corriendo
- Revisa que hay tareas en la tabla `tarea`
- Mira los logs del backend

### Error 404 al crear tarea
**Solución:**
- Verifica que el endpoint POST existe en el backend
- Revisa que los campos del JSON coinciden con la entidad

## 📚 Archivos Clave

| Archivo | Descripción |
|---------|------------|
| `lib/main.dart` | Configuración global de la app, tema, Provider setup |
| `lib/models/tarea.dart` | Modelo de datos con fromJson/toJson |
| `lib/services/tarea_service.dart` | Cliente HTTP con métodos CRUD |
| `lib/providers/tarea_provider.dart` | Estado global con Provider |
| `lib/pages/lista_tareas_page.dart` | Pantalla principal |
| `lib/pages/add_edit_tarea_page.dart` | Formulario |
| `lib/widgets/tarea_card.dart` | Widget de tarjeta |

## 🎯 Siguientes Pasos

1. ✅ Instala dependencias: `flutter pub get`
2. ✅ Configura la URL del backend en `tarea_service.dart`
3. ✅ Inicia el backend Spring Boot
4. ✅ Ejecuta: `flutter run`
5. ✅ Prueba todas las funcionalidades

## 📞 Soporte

Para problemas o preguntas:
1. Revisa los logs con `flutter logs`
2. Verifica la consola del backend
3. Comprueba la conexión a la base de datos

---

**Created with ❤️ for TaskifyApp**
