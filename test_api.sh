#!/bin/bash

# TaskifyApp - Ejemplos de pruebas API con curl
# Este script contiene ejemplos de cómo probar la API REST

BASE_URL="http://localhost:8080/api/tareas"

echo "═══════════════════════════════════════════════════════════════"
echo "         TaskifyApp - Pruebas de API REST"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# 1️⃣ LISTAR TAREAS
echo "📋 [1] GET - Listar todas las tareas"
echo "   URL: GET $BASE_URL"
curl -X GET "$BASE_URL" \
  -H "Content-Type: application/json" \
  -w "\n   Status: %{http_code}\n\n"

# 2️⃣ CREAR TAREA
echo "➕ [2] POST - Crear nueva tarea"
echo "   URL: POST $BASE_URL"
curl -X POST "$BASE_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Estudiar Flutter",
    "descripcion": "Aprender widgets y state management",
    "fechaEntrega": "2025-11-20",
    "estado": "PENDIENTE"
  }' \
  -w "\n   Status: %{http_code}\n\n"

# 3️⃣ OBTENER TAREA
echo "🔍 [3] GET - Obtener tarea por ID"
echo "   URL: GET $BASE_URL/1"
curl -X GET "$BASE_URL/1" \
  -H "Content-Type: application/json" \
  -w "\n   Status: %{http_code}\n\n"

# 4️⃣ ACTUALIZAR TAREA
echo "✏️  [4] PUT - Actualizar tarea"
echo "   URL: PUT $BASE_URL/1"
curl -X PUT "$BASE_URL/1" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Estudiar Flutter - Actualizado",
    "descripcion": "Aprender widgets, state management y animations",
    "fechaEntrega": "2025-11-25",
    "estado": "COMPLETADA"
  }' \
  -w "\n   Status: %{http_code}\n\n"

# 5️⃣ ELIMINAR TAREA
echo "🗑️  [5] DELETE - Eliminar tarea"
echo "   URL: DELETE $BASE_URL/1"
curl -X DELETE "$BASE_URL/1" \
  -H "Content-Type: application/json" \
  -w "\n   Status: %{http_code}\n\n"

echo "✅ Pruebas completadas"
