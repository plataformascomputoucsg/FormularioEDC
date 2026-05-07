# Etapa 1: Compilar el proyecto con Maven
FROM maven:3.6.3-jdk-8 AS build
WORKDIR /app
COPY pom.xml .
# Descargar dependencias primero (cache de Docker)
RUN mvn dependency:resolve
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Desplegar en Tomcat 8.5 (compatible con Servlet 3.1)
FROM tomcat:8.5-jdk8
# Eliminar las apps por defecto
RUN rm -rf /usr/local/tomcat/webapps/*
# Copiar el WAR como ROOT para que cargue en /
COPY --from=build /app/target/formularioEDC.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
