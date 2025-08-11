# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir a este repositorio de aprendizaje de Docker!

## 📋 Cómo Contribuir

### 🐛 Reportar Errores

Si encuentras un error o problema:

1. **Busca si ya existe un issue** similar
2. **Crea un nuevo issue** con:
   - Título descriptivo
   - Descripción detallada del problema
   - Pasos para reproducir
   - Comportamiento esperado vs. actual
   - Capturas de pantalla (si aplica)

### 💡 Sugerir Mejoras

Para nuevas funcionalidades o mejoras:

1. **Crea un issue** con la etiqueta `enhancement`
2. **Describe la funcionalidad** que te gustaría ver
3. **Explica por qué** sería útil
4. **Proporciona ejemplos** si es posible

### 🔧 Contribuir con Código

#### 1. Fork y Clone
```bash
# Haz fork del repositorio en GitHub
# Luego clona tu fork localmente
git clone https://github.com/dhduartea/learning-docker.git
cd learning-docker
```

#### 2. Configura el Repositorio Remoto
```bash
# Agrega el repositorio original como upstream
git remote add upstream https://github.com/dhduartea/learning-docker.git

# Verifica los remotos
git remote -v
```

#### 3. Crea una Rama para tu Feature
```bash
# Actualiza tu rama principal
git checkout main
git pull upstream main

# Crea una nueva rama
git checkout -b feature/nombre-de-tu-feature
```

#### 4. Desarrolla tu Feature
- **Sigue las convenciones** del proyecto
- **Escribe código limpio** y bien documentado
- **Prueba tu código** antes de hacer commit
- **Mantén commits pequeños** y descriptivos

#### 5. Commit y Push
```bash
# Agrega tus cambios
git add .

# Haz commit con mensaje descriptivo
git commit -m "feat: agregar nueva funcionalidad X"

# Push a tu fork
git push origin feature/nombre-de-tu-feature
```

#### 6. Crea un Pull Request
1. Ve a tu fork en GitHub
2. Haz clic en "New Pull Request"
3. Selecciona tu rama de feature
4. Completa la plantilla del PR
5. Envía el PR

## 📝 Convenciones del Proyecto

### Estructura de Commits
Usamos [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` Nueva funcionalidad
- `fix:` Corrección de bug
- `docs:` Cambios en documentación
- `style:` Cambios de formato
- `refactor:` Refactorización de código
- `test:` Agregar o modificar tests
- `chore:` Tareas de mantenimiento

### Estructura de Archivos
- **Ejercicios**: Organizados por módulo (03_05, 03_06, etc.)
- **Documentación**: En la raíz del proyecto
- **Scripts**: En sus respectivos directorios de ejercicio

### Nomenclatura
- **Directorios**: En minúsculas con guiones bajos (ej: `03_05`)
- **Archivos**: En minúsculas con guiones bajos (ej: `dockerfile`, `entrypoint.bash`)
- **Variables**: En mayúsculas para constantes, camelCase para variables

## 🧪 Testing

Antes de hacer commit, asegúrate de:

1. **Probar tus cambios** localmente
2. **Verificar que no rompas** funcionalidades existentes
3. **Ejecutar los ejercicios** que hayas modificado
4. **Verificar la sintaxis** de Dockerfiles y scripts

## 📚 Recursos Útiles

- [Docker Documentation](https://docs.docker.com/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 🎯 Áreas de Contribución

### Prioridad Alta
- Corrección de errores en ejercicios
- Mejoras en la documentación
- Nuevos ejemplos prácticos

### Prioridad Media
- Optimización de Dockerfiles
- Nuevos ejercicios complementarios
- Mejoras en scripts de automatización

### Prioridad Baja
- Cambios cosméticos
- Nuevas funcionalidades experimentales
- Traducciones a otros idiomas

## ❓ ¿Necesitas Ayuda?

Si tienes dudas sobre cómo contribuir:

1. **Revisa los issues existentes** para ver ejemplos
2. **Pregunta en un issue** o en la sección de discusiones
3. **Contacta a los maintainers** del proyecto

## 🙏 Agradecimientos

¡Gracias por contribuir a hacer este repositorio mejor para todos los estudiantes de Docker!

---

**Nota**: Este repositorio es para fines educativos. Por favor, respeta los derechos de autor del curso original de LinkedIn Learning.
