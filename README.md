# 🐳 Learning Docker - Ejercicios y Recursos

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-En%20Desarrollo-orange.svg)]()

## 📚 Descripción

Este repositorio contiene todos los ejercicios, ejemplos y recursos del curso **Learning Docker** de LinkedIn Learning. Aquí encontrarás una colección completa de prácticas, Dockerfiles, scripts y comandos para dominar Docker desde lo básico hasta conceptos avanzados.

## 🎯 Objetivos del Curso

- ✅ **Fundamentos de Docker**: Imágenes, contenedores y conceptos básicos
- ✅ **Gestión de Contenedores**: Crear, ejecutar y administrar contenedores
- ✅ **Construcción de Imágenes**: Crear Dockerfiles personalizados
- ✅ **Redes y Comunicación**: Conectar contenedores y servicios
- ✅ **Volúmenes y Persistencia**: Manejar datos y estado
- ✅ **Docker Compose**: Orquestar aplicaciones multi-contenedor
- ✅ **Buenas Prácticas**: Optimización y seguridad

## 📁 Estructura del Repositorio

```
Exercise Files/
├── 03_05/                 # Ejercicios básicos de Docker
├── 03_06/                 # Servidores y contenedores
├── 03_08/                 # Servidores web
├── 03_14_before/         # Estado antes de la práctica
├── 03_14_after/          # Estado después de la práctica
├── 04_03_before/         # Ejercicios de aplicación
├── 04_03_after/          # Soluciones de aplicación
└── docker-bash-commands-reference.md  # Guía completa de comandos
```

## 🚀 Cómo Usar Este Repositorio

### Prerrequisitos
- Docker Desktop instalado
- Conocimientos básicos de línea de comandos
- Editor de código (VS Code recomendado)

### Inicio Rápido
1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/learning-docker.git
   cd learning-docker
   ```

2. **Navega a un ejercicio específico:**
   ```bash
   cd "03_05"
   ```

3. **Construye y ejecuta:**
   ```bash
   docker build -t mi-ejercicio .
   docker run -it mi-ejercicio
   ```

## 📖 Guía de Comandos

El archivo `docker-bash-commands-reference.md` contiene una referencia completa de todos los comandos Docker y Bash que aprenderás en el curso, organizados por categorías:

- 🐳 **Docker Básico**: Construcción, verificación e información
- 🖼️ **Gestión de Imágenes**: Listar, eliminar y manipular imágenes
- 📦 **Gestión de Contenedores**: Crear, ejecutar y administrar contenedores
- 🌐 **Redes y Puertos**: Configuración de networking
- 💾 **Volúmenes y Datos**: Persistencia y almacenamiento
- ⚡ **BuildKit y buildx**: Construcción avanzada
- 🐚 **Bash**: Comandos del sistema y scripting

## 🎓 Ejercicios Incluidos

### Módulo 03: Fundamentos
- **03_05**: Primeros pasos con Docker
- **03_06**: Servidores y contenedores básicos
- **03_08**: Servidores web con Docker

### Módulo 04: Aplicaciones Prácticas
- **04_03**: Aplicaciones reales con Docker

### Módulo 03_14: Proyecto Completo
- **03_14_before**: Estado inicial del proyecto
- **03_14_after**: Proyecto completado y funcional

## 🔧 Comandos Útiles

### Construir una imagen
```bash
docker build -t nombre-imagen .
```

### Ejecutar un contenedor
```bash
docker run -it nombre-imagen
```

### Ver contenedores en ejecución
```bash
docker ps
```

### Ver todas las imágenes
```bash
docker images
```

## 📝 Contribuciones

Este repositorio está diseñado para el aprendizaje personal, pero si encuentras errores o quieres sugerir mejoras:

1. Haz un Fork del repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🙏 Agradecimientos

- **LinkedIn Learning** por el excelente curso
- **Instructores** por compartir su conocimiento
- **Comunidad Docker** por las herramientas y documentación

## 📞 Contacto

Si tienes preguntas sobre este repositorio o el curso:

- 📧 Email: [dhduartea@gmail.com]
- 🐙 GitHub: [@dhduartea]
- 💼 LinkedIn: [dhduartea]

---

## ⭐ ¿Te gustó este repositorio?

¡Dale una estrella! ⭐ Esto ayuda a que más personas encuentren estos recursos de aprendizaje.

---

**Nota**: Este repositorio es para fines educativos. Los ejercicios están basados en el curso oficial de LinkedIn Learning.
