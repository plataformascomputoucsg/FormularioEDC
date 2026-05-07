#!/bin/bash
# Restaura las clases compiladas y librerías dentro del webapp montado
echo "Preparando webapp..."
# Aseguramos que existan los directorios básicos
mkdir -p /opt/tomcat/webapps/ROOT/WEB-INF/classes
mkdir -p /opt/tomcat/webapps/ROOT/WEB-INF/lib

# Restauramos todo lo necesario al inicio
cp -r /app/build-cache/classes/. /opt/tomcat/webapps/ROOT/WEB-INF/classes/
cp -r /app/build-cache/lib/. /opt/tomcat/webapps/ROOT/WEB-INF/lib/

echo "Iniciando Tomcat en modo foreground..."
exec /opt/tomcat/bin/catalina.sh run
exec /opt/tomcat/bin/catalina.sh run
