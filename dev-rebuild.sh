#!/bin/bash
# Recompila los cambios Java y los despliega en Tomcat (dentro del contenedor)
echo "Recompilando Java..."
docker exec formulario-edc-dev bash -c "
    echo 'Recompilando Java (modo offline)...' && 
    cd /app && 
    mvn compile -q -DskipTests && 
    echo 'Sincronizando clases...' &&
    cp -r target/classes/* /opt/tomcat/webapps/ROOT/WEB-INF/classes/ &&
    echo 'Limpiando cache de JSPs...' &&
    rm -rf /opt/tomcat/work/Catalina/localhost/ROOT/* &&
    echo 'Gatillando recarga de Tomcat...' &&
    touch /opt/tomcat/webapps/ROOT/WEB-INF/web.xml
"
echo "¡Listo! Los cambios Java ya están desplegados."
