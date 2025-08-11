# 🐳 Docker & Bash - Guía de Comandos de Referencia

## 📋 Tabla de Contenidos
- [Docker Básico](#Docker-Básico)
- [Gestión de Imágenes](#gestión-de-imágenes)
- [Gestión de Contenedores](#gestión-de-contenedores)
- [Redes y Puertos](#redes-y-puertos)
- [Volúmenes y Datos](#volúmenes-y-datos)
- [BuildKit y buildx](#buildkit-y-buildx)
- [Comandos con xargs](#comandos-con-xargs)
- [Comandos de Sistema](#comandos-de-sistema)
- [Bash Básico](#bash-básico)
- [Comandos de Archivos](#comandos-de-archivos)
- [Procesos y Sistema](#procesos-y-sistema)
- [Redes](#Redes)
- [Ejemplos Prácticos](#ejemplos-prácticos)

---

## 🐳 Docker Básico

### Construcción de Imágenes
```bash
# Construir imagen desde directorio actual
docker build -t nombre-imagen .

# Construir desde directorio específico
docker build -t nombre-imagen /ruta/al/directorio

# Construir con etiqueta específica
docker build -t nombre-imagen:version .

# Construir sin usar caché
docker build --no-cache -t nombre-imagen .

# Construir con BuildKit habilitado
DOCKER_BUILDKIT=1 docker build -t nombre-imagen .

# Construir con progreso detallado
docker build --progress=plain -t nombre-imagen .

# Construir imagen que tiene un nombre de archivo específico
docker build --file file.Dockerfile -t nombre-imagen .
```

### Verificación y Información
```bash
# Ver versión de Docker
docker --version

# Ver información del sistema Docker
docker info

# Ver estadísticas de uso
docker stats

# Ver espacio usado por Docker
docker system df

# Ver logs de un contenedor
docker logs nombre-contenedor

# Ver logs en tiempo real
docker logs -f nombre-contenedor

# Ver logs de las últimas N líneas
docker logs --tail 100 nombre-contenedor
```

---

## 🖼️ Gestión de Imágenes

### Listar y Ver Imágenes
```bash
# Listar todas las imágenes
docker images
# o
docker image ls

# Listar imágenes con formato específico
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

# Listar imágenes sin truncar
docker images --no-trunc

# Buscar imágenes en Docker Hub
docker search nombre-imagen

# Ver detalles de una imagen
docker inspect nombre-imagen

# Ver historial de una imagen
docker history nombre-imagen
```

### Eliminar Imágenes
```bash
# Eliminar imagen específica
docker rmi nombre-imagen

# Eliminar imagen forzadamente
docker rmi -f nombre-imagen

# Eliminar imagen por ID
docker rmi imagen-id

# Eliminar todas las imágenes no utilizadas
docker image prune

# Eliminar todas las imágenes (¡CUIDADO!)
docker rmi $(docker images -q)

# Eliminar imágenes usando xargs (más seguro)
docker images -q | xargs docker rmi

# Eliminar imágenes sin etiqueta (dangling)
docker image prune --filter="dangling=true"

# Eliminar imágenes sin etiqueta con xargs
docker images -f "dangling=true" -q | xargs docker rmi

# Eliminar imágenes por etiqueta específica
docker images -q --filter "label=version=1.0" | xargs docker rmi

# Eliminar imágenes más antiguas que X días
docker images -q --filter "before=imagen:tag" | xargs docker rmi

# Eliminar imágenes con confirmación
docker images -q | xargs -p docker rmi

# Eliminar imágenes forzadamente con xargs
docker images -q | xargs docker rmi -f
```

### Importar/Exportar Imágenes
```bash
# Guardar imagen como archivo tar
docker save -o imagen.tar nombre-imagen

# Cargar imagen desde archivo tar
docker load -i imagen.tar

# Exportar contenedor como imagen
docker export contenedor-id > contenedor.tar

# Importar contenedor desde archivo tar
docker import contenedor.tar nombre-imagen:tag
```

---

## 📦 Gestión de Contenedores

### Ejecutar Contenedores
```bash
# Ejecutar contenedor
docker run nombre-imagen

# Ejecutar en modo interactivo
docker run -it nombre-imagen

# Ejecutar en segundo plano
docker run -d nombre-imagen

# Ejecutar con nombre específico
docker run --name mi-contenedor nombre-imagen

# Ejecutar con nombre usando variables de entorno
docker run --name $NOMBRE_CONTENEDOR nombre-imagen

# Ejecutar con nombre basado en fecha/hora
docker run --name "app-$(date +%Y%m%d-%H%M%S)" nombre-imagen

# Ejecutar con nombre basado en directorio actual
docker run --name "app-$(basename $(pwd))" nombre-imagen

# Ejecutar y eliminar automáticamente
docker run --rm nombre-imagen

# Ejecutar con variables de entorno
docker run -e VARIABLE=valor nombre-imagen

# Ejecutar con archivo de variables de entorno
docker run --env-file .env nombre-imagen

# Ejecutar con límites de recursos
docker run --memory=512m --cpus=1 nombre-imagen

# Ejecutar con usuario específico
docker run -u usuario:grupo nombre-imagen
```

### Listar y Ver Contenedores
```bash
# Listar contenedores en ejecución
docker ps

# Listar todos los contenedores
docker ps -a

# Listar contenedores con formato específico
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Listar solo IDs de contenedores
docker ps -q

# Listar contenedores filtrados
docker ps --filter "status=running"

# Ver detalles de un contenedor
docker inspect nombre-contenedor

# Ver logs de un contenedor
docker logs nombre-contenedor
```

### Controlar Contenedores
```bash
# Detener contenedor
docker stop nombre-contenedor

# Detener contenedor forzadamente
docker kill nombre-contenedor

# Iniciar contenedor
docker start nombre-contenedor

# Reiniciar contenedor
docker restart nombre-contenedor

# Pausar contenedor
docker pause nombre-contenedor

# Reanudar contenedor
docker unpause nombre-contenedor

# Ejecutar comando dentro del contenedor
docker exec -it nombre-contenedor bash

# Ejecutar comando como usuario específico
docker exec -u usuario nombre-contenedor comando
```

### Nomenclatura y Renombrado de Contenedores
```bash
# Verificar si un nombre ya existe
docker ps -a --filter "name=mi-contenedor"

# Renombrar contenedor existente
docker rename contenedor-viejo nuevo-nombre

# Renombrar contenedor usando ID
docker rename abc123 nuevo-nombre

# Renombrar contenedor con timestamp
docker rename mi-contenedor "mi-contenedor-$(date +%Y%m%d)"

# Renombrar contenedor con sufijo
docker rename mi-contenedor mi-contenedor-backup

# Verificar nombres duplicados antes de crear
if ! docker ps -a --filter "name=mi-contenedor" --format "{{.Names}}" | grep -q "mi-contenedor"; then
    docker run --name mi-contenedor nombre-imagen
else
    echo "El nombre ya existe"
fi

# Crear contenedor con nombre único automático
docker run --name "app-$(date +%s)" nombre-imagen

# Crear contenedor con nombre basado en imagen
docker run --name "$(basename nombre-imagen)-$(date +%H%M%S)" nombre-imagen

# Crear contenedor con nombre secuencial
docker run --name "app-$(docker ps -aq | wc -l | xargs printf "%03d")" nombre-imagen
```

### Eliminar Contenedores
```bash
# Eliminar contenedor específico
docker rm nombre-contenedor

# Eliminar contenedor forzadamente
docker rm -f nombre-contenedor

# Eliminar contenedor y su imagen
docker rm -f nombre-contenedor && docker rmi nombre-imagen

# Eliminar todos los contenedores detenidos
docker container prune

# Eliminar todos los contenedores (¡CUIDADO!)
docker rm $(docker ps -aq)

# Eliminar contenedores usando xargs (más seguro)
docker ps -aq | xargs docker rm

# Eliminar contenedores filtrados
docker rm $(docker ps -aq --filter "status=exited")

# Eliminar contenedores filtrados con xargs
docker ps -aq --filter "status=exited" | xargs docker rm

# Eliminar contenedores por nombre específico
docker ps -aq --filter "name=mi-contenedor" | xargs docker rm

# Eliminar contenedores más antiguos que X días
docker ps -aq --filter "label=created=$(date -d '7 days ago' +%Y-%m-%d)" | xargs docker rm

# Eliminar contenedores con confirmación
docker ps -aq | xargs -p docker rm

# Eliminar contenedores y sus volúmenes
docker ps -aq | xargs docker rm -v

# Eliminar contenedores y sus imágenes asociadas
docker ps -aq | xargs docker rm -f && docker images -q | xargs docker rmi -f
```

---

## 🌐 Redes y Puertos

### Gestión de Redes
```bash
# Listar redes
docker network ls

# Crear red personalizada
docker network create mi-red

# Crear red con driver específico
docker network create --driver bridge mi-red

# Eliminar red
docker network rm nombre-red

# Ver detalles de una red
docker inspect nombre-red

# Conectar contenedor a red
docker network connect nombre-red nombre-contenedor

# Desconectar contenedor de red
docker network disconnect nombre-red nombre-contenedor
```

### Mapeo de Puertos
```bash
# Mapear puerto específico
docker run -p 8080:80 nombre-imagen

# Mapear puerto con IP específica
docker run -p 127.0.0.1:8080:80 nombre-imagen

# Mapear puerto aleatorio
docker run -P nombre-imagen

# Mapear múltiples puertos
docker run -p 8080:80 -p 3000:3000 nombre-imagen

# Ver puertos mapeados
docker port nombre-contenedor
```

---

## 💾 Volúmenes y Datos

### Gestión de Volúmenes
```bash
# Listar volúmenes
docker volume ls

# Crear volumen
docker volume create mi-volumen

# Eliminar volumen
docker volume rm nombre-volumen

# Ver detalles de volumen
docker inspect nombre-volumen

# Eliminar volúmenes no utilizados
docker volume prune
```

### Montaje de Volúmenes
```bash
# Montar volumen nombrado
docker run -v mi-volumen:/app/data nombre-imagen

# Montar directorio del host
docker run -v /ruta/local:/ruta/contenedor nombre-imagen

# Montar archivo específico
docker run -v /ruta/archivo:/app/config.json nombre-imagen

# Montar con permisos específicos
docker run -v /ruta/local:/ruta/contenedor:ro nombre-imagen
```

---

## ⚡ BuildKit y buildx

### Habilitar BuildKit
```bash
# Habilitar temporalmente (Windows PowerShell)
$env:DOCKER_BUILDKIT=1
docker build -t imagen .

# Habilitar temporalmente (Linux/Mac)
export DOCKER_BUILDKIT=1
docker build -t imagen .

# Verificar si está activo
docker build --progress=plain -t test .
```

### Comandos buildx
```bash
# Instalar buildx
docker buildx install

# Ver builders disponibles
docker buildx ls

# Crear nuevo builder
docker buildx create --name mybuilder --use

# Construir para múltiples plataformas
docker buildx build --platform linux/amd64,linux/arm64 -t imagen .

# Usar caché remoto
docker buildx build --cache-from=type=registry,ref=usuario/imagen:cache .
```

---

## 🔧 Comandos con xargs

### Operaciones Masivas con xargs
```bash
# Eliminar todos los contenedores
docker ps -aq | xargs docker rm

# Eliminar todas las imágenes
docker images -q | xargs docker rmi

# Detener todos los contenedores
docker ps -q | xargs docker stop

# Iniciar todos los contenedores detenidos
docker ps -aq --filter "status=exited" | xargs docker start

# Reiniciar todos los contenedores
docker ps -q | xargs docker restart

# Pausar todos los contenedores
docker ps -q | xargs docker pause

# Reanudar todos los contenedores pausados
docker ps -aq --filter "status=paused" | xargs docker unpause

# Ver logs de todos los contenedores
docker ps -q | xargs -I {} docker logs {}

# Ejecutar comando en todos los contenedores
docker ps -q | xargs -I {} docker exec {} comando

# Ver estadísticas de todos los contenedores
docker ps -q | xargs docker stats --no-stream

# Eliminar contenedores con confirmación
docker ps -aq | xargs -p docker rm

# Eliminar imágenes con confirmación
docker images -q | xargs -p docker rmi

# Eliminar volúmenes no utilizados
docker volume ls -q | xargs docker volume rm

# Eliminar redes no utilizadas
docker network ls -q | xargs docker network rm
```

### Filtros Útiles con xargs
```bash
# Eliminar contenedores por estado
docker ps -aq --filter "status=exited" | xargs docker rm

# Eliminar contenedores por nombre
docker ps -aq --filter "name=test" | xargs docker rm

# Eliminar contenedores por etiqueta
docker ps -aq --filter "label=environment=dev" | xargs docker rm

# Eliminar contenedores por patrón de nombre
docker ps -aq --filter "name=app-*" | xargs docker rm

# Eliminar contenedores por sufijo de nombre
docker ps -aq --filter "name=*-test" | xargs docker rm

# Renombrar múltiples contenedores por patrón
docker ps -aq --filter "name=dev-*" | xargs -I {} docker rename {} "prod-{}"

# Ejecutar comando en contenedores por patrón de nombre
docker ps -q --filter "name=web-*" | xargs -I {} docker exec {} comando

# Eliminar imágenes por etiqueta
docker images -q --filter "label=version=1.0" | xargs docker rmi

# Eliminar imágenes sin etiqueta (dangling)
docker images -f "dangling=true" -q | xargs docker rmi

# Eliminar contenedores más antiguos que 7 días
docker ps -aq --filter "label=created=$(date -d '7 days ago' +%Y-%m-%d)" | xargs docker rm
```

### Operaciones con Paralelización
```bash
# Eliminar contenedores en paralelo (más rápido)
docker ps -aq | xargs -P 4 docker rm

# Eliminar imágenes en paralelo
docker images -q | xargs -P 4 docker rmi

# Construir múltiples imágenes en paralelo
echo "imagen1 imagen2 imagen3" | xargs -n 1 -P 3 docker build -t
```

---

## 🛠️ Comandos de Sistema

### Limpieza y Mantenimiento
```bash
# Limpiar recursos no utilizados
docker system prune

# Limpiar todo (¡CUIDADO!)
docker system prune -a

# Ver espacio usado
docker system df

# Ver información detallada
docker system info

# Verificar Docker daemon
docker version
```

### Monitoreo
```bash
# Ver estadísticas en tiempo real
docker stats

# Ver estadísticas de contenedor específico
docker stats nombre-contenedor

# Ver estadísticas con formato específico
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

---

## 🐚 Bash Básico

### Navegación
```bash
# Cambiar directorio
cd /ruta/directorio

# Ir al directorio home
cd ~
# o
cd

# Ir al directorio anterior
cd ..

# Ir al directorio padre del padre
cd ../..

# Ir al directorio anterior (historial)
cd -
```

### Listar y Ver
```bash
# Listar archivos
ls

# Listar archivos con detalles
ls -la

# Listar archivos con formato específico
ls -lh

# Listar archivos ocultos
ls -a

# Listar archivos por fecha
ls -lt

# Ver contenido de archivo
cat archivo.txt

# Ver primeras líneas
head archivo.txt

# Ver primeras N líneas
head -n 10 archivo.txt

# Ver últimas líneas
tail archivo.txt

# Ver últimas N líneas
tail -n 10 archivo.txt

# Ver archivo página por página
less archivo.txt
# o
more archivo.txt
```

### Información del Sistema
```bash
# Ver directorio actual
pwd

# Ver usuario actual
whoami

# Ver información del sistema
uname -a

# Ver versión del sistema
cat /etc/os-release

# Ver información de memoria
free -h

# Ver uso de disco
df -h

# Ver información de CPU
lscpu
```

---

## 📁 Comandos de Archivos

### Crear y Eliminar
```bash
# Crear directorio
mkdir nombre-directorio

# Crear directorios anidados
mkdir -p padre/hijo/nieto

# Crear archivo vacío
touch archivo.txt

# Eliminar archivo
rm archivo.txt

# Eliminar directorio vacío
rmdir nombre-directorio

# Eliminar directorio y contenido
rm -rf nombre-directorio

# Eliminar con confirmación
rm -i archivo.txt
```

### Copiar y Mover
```bash
# Copiar archivo
cp origen.txt destino.txt

# Copiar directorio
cp -r origen/ destino/

# Copiar preservando atributos
cp -p origen.txt destino.txt

# Mover/renombrar archivo
mv archivo-viejo.txt archivo-nuevo.txt

# Mover archivo a directorio
mv archivo.txt /ruta/directorio/
```

### Buscar Archivos
```bash
# Buscar archivo por nombre
find /ruta -name "archivo.txt"

# Buscar archivo por extensión
find . -name "*.txt"

# Buscar archivo por tamaño
find . -size +100M

# Buscar archivo por fecha
find . -mtime -7

# Buscar texto en archivos
grep "texto" archivo.txt

# Buscar texto en múltiples archivos
grep -r "texto" directorio/

# Buscar texto ignorando mayúsculas
grep -i "texto" archivo.txt
```

---

## 🔄 Procesos y Sistema

### Gestión de Procesos
```bash
# Ver procesos en ejecución
ps aux

# Ver procesos de usuario actual
ps

# Ver procesos en formato árbol
ps -ejH

# Matar proceso por PID
kill PID

# Matar proceso forzadamente
kill -9 PID

# Matar proceso por nombre
pkill nombre-proceso

# Matar proceso forzadamente por nombre
pkill -9 nombre-proceso
```

### Monitoreo del Sistema
```bash
# Ver uso de CPU y memoria en tiempo real
top

# Ver uso de CPU y memoria (formato simple)
htop

# Ver información de memoria
free -h

# Ver uso de disco
df -h

# Ver uso de disco por directorio
du -h directorio/

# Ver uso de disco del directorio actual
du -sh .
```

---

## 🌐 Redes

### Información de Red
```bash
# Ver interfaces de red
ip addr show
# o
ifconfig

# Ver rutas de red
ip route show
# o
route -n

# Ver conexiones activas
netstat -tuln

# Ver conexiones con procesos
netstat -tulnp

# Probar conectividad
ping google.com

# Ver información de DNS
nslookup google.com

# Ver información de dominio
dig google.com
```

### Descarga de Archivos
```bash
# Descargar archivo
wget https://ejemplo.com/archivo.zip

# Descargar archivo con nombre específico
wget -O mi-archivo.zip https://ejemplo.com/archivo.zip

# Descargar archivo en segundo plano
wget -b https://ejemplo.com/archivo.zip

# Descargar con curl
curl -O https://ejemplo.com/archivo.zip

# Descargar con nombre específico
curl -o mi-archivo.zip https://ejemplo.com/archivo.zip
```

---

## 🎯 Ejemplos Prácticos

### Desarrollo Web
```bash
# Ejecutar aplicación Node.js
docker run -d -p 3000:3000 --name mi-app node:18

# Ejecutar aplicación Python
docker run -d -p 8000:8000 --name mi-app python:3.9

# Ejecutar base de datos MySQL
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password --name mi-db mysql:8.0

# Ejecutar aplicación con volúmenes
docker run -d -p 8080:80 -v $(pwd):/app --name mi-app nginx
```

### Debugging
```bash
# Entrar a contenedor en ejecución
docker exec -it nombre-contenedor bash

# Ver logs en tiempo real
docker logs -f nombre-contenedor

# Ver uso de recursos
docker stats nombre-contenedor

# Ver configuración del contenedor
docker inspect nombre-contenedor
```

### Nomenclatura y Organización
```bash
# Crear contenedores con nombres descriptivos
docker run -d --name "web-server-$(date +%Y%m%d)" nginx
docker run -d --name "db-mysql-$(date +%H%M)" mysql:8.0

# Crear contenedores con nombres basados en entorno
docker run -d --name "app-${ENVIRONMENT:-dev}-$(date +%s)" mi-imagen

# Crear contenedores con nombres secuenciales
for i in {1..3}; do
    docker run -d --name "worker-$(printf "%02d" $i)" mi-imagen
done

# Renombrar contenedores para backup
docker rename mi-app mi-app-backup-$(date +%Y%m%d)

# Crear contenedores con nombres únicos usando UUID
docker run -d --name "app-$(uuidgen | cut -d'-' -f1)" mi-imagen
```

### Limpieza
```bash
# Limpiar contenedores detenidos
docker container prune

# Limpiar imágenes no utilizadas
docker image prune

# Limpiar volúmenes no utilizados
docker volume prune

# Limpiar redes no utilizadas
docker network prune

# Limpiar todo
docker system prune -a
```

---

## 📝 Notas Importantes

### Variables de Entorno Útiles
```bash
# Habilitar BuildKit
export DOCKER_BUILDKIT=1

# Configurar formato de salida
export DOCKER_FORMAT="table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Configurar timeout
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120
```

### Atajos Útiles
```bash
# Eliminar contenedor al salir
docker run --rm nombre-imagen

# Ejecutar comando y salir
docker run --rm nombre-imagen comando

# Montar directorio actual
docker run -v $(pwd):/app nombre-imagen

# Ejecutar con variables de entorno del host
docker run --env-file .env nombre-imagen

# Crear contenedor con nombre del directorio actual
docker run -d --name "$(basename $(pwd))" nombre-imagen

# Crear contenedor con nombre y timestamp
docker run -d --name "app-$(date +%Y%m%d-%H%M%S)" nombre-imagen
```

---

## 🔗 Recursos Adicionales

- [Documentación oficial de Docker](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)

---

*📚 Esta guía se actualiza regularmente. Última actualización: $(Get-Date)* 