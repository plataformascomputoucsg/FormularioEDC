# Formulario EDC

Aplicación web **Spring MVC 4** con vistas JSP, acceso a base de datos Oracle y entorno de desarrollo completamente **Dockerizado** (Tomcat 8.5 + BrowserSync).

---

## Requisitos previos

| Herramienta | Versión mínima | Notas |
|-------------|----------------|-------|
| [Docker Desktop](https://www.docker.com/products/docker-desktop/) | 4.x | Debe estar corriendo antes de levantar el proyecto |
| [Git](https://git-scm.com/) | Cualquiera | Para clonar el repositorio |
| JDK 8 | 1.8 | **Solo** si se quiere compilar localmente sin Docker |
| Maven | 3.6+ | **Solo** si se compila localmente sin Docker |

> **Nota:** El entorno de desarrollo está pensado para correr 100 % en Docker. No necesitas instalar Java ni Maven en tu máquina si usas el flujo Docker.

---

## Estructura del proyecto

```
formularioEDC/
├── src/
│   └── main/
│       ├── java/com/miproducto/   # Código Java (controllers, dao, dto, models, config)
│       ├── resources/
│       │   └── application.properties  # Credenciales y URL de BD
│       └── webapp/
│           └── WEB-INF/views/     # Vistas JSP
├── Dockerfile.dev                 # Imagen Docker de desarrollo (Maven + Tomcat 8.5)
├── docker-compose.dev.yml         # Orquestación: app + BrowserSync
├── bs-config.js                   # Configuración de BrowserSync
├── dev-rebuild.sh                 # Script para recompilar Java sin reiniciar el contenedor
├── dev-entrypoint.sh              # Entrypoint del contenedor de desarrollo
└── pom.xml                        # Dependencias Maven
```

---

## Configuración inicial

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
cd formularioEDC
```

### 2. Configurar la conexión a la base de datos

Edita el archivo `src/main/resources/application.properties` con los datos de conexión a Oracle:

```properties
db.url=jdbc:oracle:thin:@<HOST>:<PUERTO>:<SID>
db.username=<USUARIO>
db.password=<CONTRASEÑA>
```

> ⚠️ **No subas este archivo con credenciales reales al repositorio.** Considera añadirlo al `.gitignore`.

---

## Levantar el entorno de desarrollo

```bash
docker compose -f docker-compose.dev.yml up --build
```

La primera vez tomará varios minutos porque Docker descargará la imagen base y resolverá las dependencias Maven.

Una vez levantado tendrás disponibles:

| Servicio | URL | Descripción |
|----------|-----|-------------|
| Aplicación (Tomcat) | http://localhost:8080 | Servidor principal |
| BrowserSync (proxy) | http://localhost:3000 | Live reload automático del frontend |
| BrowserSync UI | http://localhost:3001 | Panel de control de BrowserSync |
| Debug remoto (JDWP) | puerto `5005` | Para conectar un debugger desde el IDE |

**Ejemplo de acceso:**

```
http://localhost:8080/formulario
```

> **Nota:** Reemplazá `formulario` por el context path de tu aplicación si es diferente.

---

## Flujo de desarrollo

### Cambios en JSP / CSS / JS (frontend)

Los archivos en `src/main/webapp/` están montados como volumen directamente en Tomcat. **BrowserSync detecta los cambios automáticamente** y recarga el navegador sin que tengas que hacer nada.

### Cambios en código Java (backend)

El contenedor no detecta cambios Java automáticamente. Debes ejecutar el script de recompilación manual:

```bash
bash dev-rebuild.sh
```

Este script:
1. Recompila las clases Java dentro del contenedor (`mvn compile`).
2. Sincroniza las clases compiladas en el webapp de Tomcat.
3. Limpia la caché de JSPs compilados.
4. Recarga el contexto de Tomcat tocando `web.xml`.

---

## Detener el entorno

```bash
docker compose -f docker-compose.dev.yml down
```

## Recrear el entorno desde cero

**Bajar y eliminar la imagen local** (fuerza un rebuild completo):

```bash
docker compose -f docker-compose.dev.yml down --rmi local
```

**Volver a construir y levantar:**

```bash
docker compose -f docker-compose.dev.yml up --build
```

> **¿Cuándo usar `--rmi local`?**
> - Cambiaste el `pom.xml` (nuevas dependencias)
> - Modificaste el `Dockerfile.dev`
> - Quieres asegurarte de que la imagen esté totalmente actualizada
>
> Si solo cambiaste código Java o JSP, usa directamente `up --build` (reutiliza el caché de Docker y es más rápido).

---

## Configurar debug remoto en el IDE

El contenedor expone el puerto `5005` para depuración remota vía JDWP.

**IntelliJ IDEA:**
1. `Run` → `Edit Configurations` → `+` → **Remote JVM Debug**
2. Host: `localhost`, Puerto: `5005`
3. Inicia el debug y agrega breakpoints normalmente.

**VS Code** (extensión [Debugger for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-debug)):

Agrega en `.vscode/launch.json`:
```json
{
  "type": "java",
  "request": "attach",
  "name": "Attach Docker (port 5005)",
  "hostName": "localhost",
  "port": 5005
}
```

---

## Stack tecnológico

| Capa | Tecnología |
|------|-----------|
| Framework web | Spring MVC 4.3.30 |
| Vistas | JSP + JSTL 1.2 |
| Validación | Hibernate Validator 5.4 |
| Base de datos | Oracle (ojdbc8 19.21) |
| Acceso a datos | Spring JDBC |
| Serialización JSON | Jackson 2.10 |
| Servidor (dev) | Apache Tomcat 8.5 |
| JDK (dev) | Trava OpenJDK 8 (DCEVM + HotswapAgent) |
| Live reload | BrowserSync 2.29 |
| Build | Maven 3.6 |
