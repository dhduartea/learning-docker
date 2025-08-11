FROM ubuntu:22.04

LABEL maintainer="David Duarte <dhduarte@gmail.com>"

# Cambiar a usuario root para instalar paquetes
USER root

# Copiar el script de entrada
COPY ./entrypoint.bash /

# Actualizar e instalar dependencias en una sola capa
RUN apt-get update && \
    apt-get install -y curl bash && \
    chmod 755 /entrypoint.bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cambiar a usuario no privilegiado por seguridad
USER nobody

# Comando que se ejecutará al iniciar el contenedor
ENTRYPOINT [ "/entrypoint.bash" ]
