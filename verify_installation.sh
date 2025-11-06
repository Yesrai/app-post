#!/bin/bash

# 🔍 Script de Verificación - TaskifyApp
# Este script verifica que todos los archivos requeridos están creados correctamente

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         TaskifyApp - Verificación de Instalación             ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contadores
total=0
verificados=0
errores=0

# Función para verificar archivo
check_file() {
    local file=$1
    local descripcion=$2
    total=$((total + 1))
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅${NC} $descripcion"
        verificados=$((verificados + 1))
        # Mostrar tamaño
        size=$(wc -c < "$file")
        echo "   └─ Tamaño: $(numfmt --to=iec-i --suffix=B $size 2>/dev/null || echo "$size bytes")"
    else
        echo -e "${RED}❌${NC} $descripcion (NO ENCONTRADO)"
        errores=$((errores + 1))
    fi
}

# Función para verificar carpeta
check_dir() {
    local dir=$1
    local descripcion=$2
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✅${NC} $descripcion"
    else
        echo -e "${RED}❌${NC} $descripcion (NO ENCONTRADO)"
    fi
}

echo "📁 Verificando estructura de carpetas..."
echo ""

check_dir "lib/models" "Carpeta: lib/models"
check_dir "lib/services" "Carpeta: lib/services"
check_dir "lib/providers" "Carpeta: lib/providers"
check_dir "lib/pages" "Carpeta: lib/pages"
check_dir "lib/widgets" "Carpeta: lib/widgets"
check_dir "lib/constants" "Carpeta: lib/constants"

echo ""
echo "📝 Verificando archivos de código Dart..."
echo ""

check_file "lib/main.dart" "main.dart - Punto de entrada"
check_file "lib/models/tarea.dart" "models/tarea.dart - Modelo"
check_file "lib/services/tarea_service.dart" "services/tarea_service.dart - Servicio HTTP"
check_file "lib/providers/tarea_provider.dart" "providers/tarea_provider.dart - Provider"
check_file "lib/pages/lista_tareas_page.dart" "pages/lista_tareas_page.dart - Pantalla lista"
check_file "lib/pages/add_edit_tarea_page.dart" "pages/add_edit_tarea_page.dart - Formulario"
check_file "lib/widgets/tarea_card.dart" "widgets/tarea_card.dart - Widget Card"
check_file "lib/constants/app_colors.dart" "constants/app_colors.dart - Colores"

echo ""
echo "📚 Verificando archivos de documentación..."
echo ""

check_file "TASKIFYAPP_README.md" "TASKIFYAPP_README.md - README principal"
check_file "TASKIFYAPP_CONFIG.md" "TASKIFYAPP_CONFIG.md - Configuración"
check_file "TIPS_Y_MEJORES_PRACTICAS.md" "TIPS_Y_MEJORES_PRACTICAS.md - Guía"
check_file "EJEMPLOS_HTTP_AVANZADOS.md" "EJEMPLOS_HTTP_AVANZADOS.md - Ejemplos"
check_file "RESUMEN_EJECUTIVO.md" "RESUMEN_EJECUTIVO.md - Resumen"
check_file "test_api.sh" "test_api.sh - Script pruebas"
check_file "TaskifyApp_API_Collection.json" "TaskifyApp_API_Collection.json - Postman"
check_file "pubspec.yaml" "pubspec.yaml - Dependencias"

echo ""
echo "🔍 Verificando dependencias en pubspec.yaml..."
echo ""

if grep -q "provider" pubspec.yaml; then
    echo -e "${GREEN}✅${NC} Dependencia: provider"
else
    echo -e "${RED}❌${NC} Dependencia: provider (NO ENCONTRADA)"
fi

if grep -q "http" pubspec.yaml; then
    echo -e "${GREEN}✅${NC} Dependencia: http"
else
    echo -e "${RED}❌${NC} Dependencia: http (NO ENCONTRADA)"
fi

if grep -q "google_fonts" pubspec.yaml; then
    echo -e "${GREEN}✅${NC} Dependencia: google_fonts"
else
    echo -e "${RED}❌${NC} Dependencia: google_fonts (NO ENCONTRADA)"
fi

if grep -q "intl" pubspec.yaml; then
    echo -e "${GREEN}✅${NC} Dependencia: intl"
else
    echo -e "${RED}❌${NC} Dependencia: intl (NO ENCONTRADA)"
fi

echo ""
echo "✨ Verificando contenido de archivos clave..."
echo ""

# Verificar que main.dart tiene las importaciones correctas
if grep -q "TaskifyApp" lib/main.dart && grep -q "ListaTareasPage" lib/main.dart; then
    echo -e "${GREEN}✅${NC} main.dart - Estructura correcta"
else
    echo -e "${RED}❌${NC} main.dart - Estructura incompleta"
fi

# Verificar que tarea_service.dart tiene los métodos CRUD
if grep -q "obtenerTareas\|crearTarea\|actualizarTarea\|eliminarTarea" lib/services/tarea_service.dart; then
    echo -e "${GREEN}✅${NC} tarea_service.dart - Métodos CRUD presentes"
else
    echo -e "${RED}❌${NC} tarea_service.dart - Métodos CRUD faltantes"
fi

# Verificar que tarea_provider.dart tiene ChangeNotifier
if grep -q "ChangeNotifier" lib/providers/tarea_provider.dart; then
    echo -e "${GREEN}✅${NC} tarea_provider.dart - ChangeNotifier configurado"
else
    echo -e "${RED}❌${NC} tarea_provider.dart - ChangeNotifier no encontrado"
fi

# Verificar que lista_tareas_page.dart tiene Consumer
if grep -q "Consumer" lib/pages/lista_tareas_page.dart; then
    echo -e "${GREEN}✅${NC} lista_tareas_page.dart - Consumer implementado"
else
    echo -e "${RED}❌${NC} lista_tareas_page.dart - Consumer no encontrado"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    RESUMEN DE VERIFICACIÓN                     ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Resultados:"
echo "   - Total de archivos requeridos: $total"
echo "   - Archivos encontrados: $verificados"
echo "   - Archivos faltantes: $errores"
echo ""

if [ $errores -eq 0 ]; then
    echo -e "${GREEN}✅ ¡VERIFICACIÓN EXITOSA!${NC}"
    echo ""
    echo "✨ Siguientes pasos:"
    echo "   1. flutter pub get              (ya completado)"
    echo "   2. flutter run                  (ejecutar en emulador)"
    echo "   3. Verificar backend en localhost:8080"
    echo ""
else
    echo -e "${RED}❌ VERIFICACIÓN CON ERRORES${NC}"
    echo ""
    echo "⚠️  Archivos faltantes: $errores"
    echo "   Revisa que todos los archivos estén en su lugar"
fi

echo ""
echo "📖 Documentación disponible:"
echo "   - TASKIFYAPP_README.md          ← Comienza aquí"
echo "   - TASKIFYAPP_CONFIG.md          ← Configuración"
echo "   - RESUMEN_EJECUTIVO.md          ← Resumen de la implementación"
echo ""
echo "🎯 Para más información, consulta los archivos README"
echo ""
