# 🌐 Ejemplos de Solicitudes HTTP - TaskifyApp

## 📋 Tabla de Contenidos
1. [curl](#curl)
2. [JavaScript/Fetch](#javascript)
3. [Python/Requests](#python)
4. [Dart/HTTP](#dart)

---

## curl

### GET - Listar tareas

```bash
curl -X GET "http://localhost:8080/api/tareas" \
  -H "Content-Type: application/json"
```

### POST - Crear tarea

```bash
curl -X POST "http://localhost:8080/api/tareas" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Estudiar Flutter",
    "descripcion": "Aprender Dart y widgets",
    "fechaEntrega": "2025-11-20",
    "estado": "PENDIENTE"
  }'
```

### PUT - Actualizar tarea

```bash
curl -X PUT "http://localhost:8080/api/tareas/1" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Estudiar Flutter - Actualizado",
    "descripcion": "Aprender todo sobre Flutter",
    "fechaEntrega": "2025-11-25",
    "estado": "COMPLETADA"
  }'
```

### DELETE - Eliminar tarea

```bash
curl -X DELETE "http://localhost:8080/api/tareas/1" \
  -H "Content-Type: application/json"
```

---

## JavaScript

### Usando Fetch API

```javascript
const baseUrl = 'http://localhost:8080/api/tareas';

// GET
async function getTareas() {
  const response = await fetch(baseUrl);
  return response.json();
}

// POST
async function createTarea(data) {
  const response = await fetch(baseUrl, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  });
  return response.json();
}

// PUT
async function updateTarea(id, data) {
  const response = await fetch(`${baseUrl}/${id}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  });
  return response.json();
}

// DELETE
async function deleteTarea(id) {
  await fetch(`${baseUrl}/${id}`, { method: 'DELETE' });
}
```

---

## Python

### Usando requests

```python
import requests

BASE_URL = 'http://localhost:8080/api/tareas'

# GET
def get_tareas():
    response = requests.get(BASE_URL)
    return response.json()

# POST
def create_tarea(titulo, descripcion, fecha, estado):
    data = {
        'titulo': titulo,
        'descripcion': descripcion,
        'fechaEntrega': fecha,
        'estado': estado
    }
    response = requests.post(BASE_URL, json=data)
    return response.json()

# PUT
def update_tarea(id, data):
    response = requests.put(f'{BASE_URL}/{id}', json=data)
    return response.json()

# DELETE
def delete_tarea(id):
    requests.delete(f'{BASE_URL}/{id}')
```

---

## Dart

### Usando http package

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIClient {
  static const baseUrl = 'http://localhost:8080/api/tareas';

  // GET
  static Future<List> getTareas() async {
    final response = await http.get(Uri.parse(baseUrl));
    return jsonDecode(response.body);
  }

  // POST
  static Future<dynamic> createTarea(Map data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  // PUT
  static Future<dynamic> updateTarea(int id, Map data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  // DELETE
  static Future<void> deleteTarea(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
```

---

**¡Elige el método que mejor se adapte a tu flujo de trabajo! 🚀**
