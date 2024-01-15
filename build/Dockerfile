# Imagen de jdk como base
FROM openjdk:11.0.15-jdk-bullseye as talend-common

# Instalar utilidades
RUN apt-get update && \
	apt-get install -y xtail tcpdump net-tools rsync libxml2-utils && \
    rm -rf /var/lib/apt/lists/*

# Copiar la carpeta desde tu máquina local a la imagen
COPY Runtime_ESBSE /Talend/Runtime_ESBSE

# Configure features
COPY features.txt /tmp
WORKDIR /Talend/Runtime_ESBSE/container/bin

# Configurar features
RUN echo "Configuring..." && \
    ./trun </tmp/features.txt

# Habilitar el ingreso a la consola
RUN sed -i 's/\(_g_\\:admingroup =.*$\)/\1,ssh/' /Talend/Runtime_ESBSE/container/etc/users.properties 

# Instala scripts y aplicaciones
COPY bin /usr/local/bin
RUN find /usr/local/bin -type f -name "*.sh" -exec dos2unix {} \;
RUN find /usr/local/bin -type f -name "*.sh" -exec sed -i 's/\r$//' {} \;

# Establece el script de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 8040
